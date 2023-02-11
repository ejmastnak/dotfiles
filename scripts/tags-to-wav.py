#!/usr/bin/env python
"""
Note: in hindsight this is probably meaningless because most WAV players don't
seem to support metadata tags.

NAME
    tags-rename.py - Rename a YAML tags file into CD order
SYNOPSIS
    tags-rename.py tagfile.yaml album.m3u [extension]
DESCRIPTION
(Incomplete, here's what's involved):
    Original tags.yaml file
    Album file album.m3u
    Adding 01, 02, etc prefix when preparing for CD
    I want to re-tag files after converting to WAV for CD
    File names in original tags.yaml don't align with WAV file names because of
    01, 02 prefixes and 

Expects a tagfile.yaml file with the following form:

    aprietala-en-el-rincon.opus:  # path to track
      title: Aprietala En El Rincon
      artist: Papaito
      album: Papaito
      year: 1980

Assumes the `title`, `artist`, `album` and `year` keys are defined for every
track; will fail ungracefully if they are not---no error checking is
implemented for these keys.

Expects an ablum.m3u file of the form:

    caramelo-a-kilo.opus
    aprietala-en-el-rincon.opus
    el-panquelero.opus

I.e. just paths to tracks.

Optional third parameter is file extension; assumes opus by default.

"""
import sys, yaml, taglib

if len(sys.argv) == 3:  # Tag and album file; assume opus extension
    extension = "opus"
elif len(sys.argv) == 4:  # User-specified extension
    extension = sys.argv[3]
else:
    print("Error: incorrect number of command line arguments.")
    print("Usage: tags-rename.py tagfile.yaml album.m3u [mp3|opus|...]")
    sys.exit()

tagfile = sys.argv[1]
albumfile = sys.argv[2]
    
# Read tags into a Python dict
with open(tagfile, "r") as stream:
    try:
        tag_dict = yaml.safe_load(stream)
    except yaml.YAMLError as exc:
        print("Error reading file.")
        print(exc)
        sys.exit()

# Read album file
n = 1
with open(albumfile) as topo_file:
    for track in topo_file:
        track = track.rstrip()  # Remove leading/trailing whitespace and new lines
        if (track[0] == "#"): continue  # Skip comments

        new_track = "{:02d}_{}".format(n, track).replace("." + extension, ".wav")

        print(new_track)

        try:
            tag_dict[new_track] = tag_dict.pop(track)
        except KeyError:
            print("KeyError for track {}".format(track))
            continue

        n += 1

# Write new tags to file system
with open('TAGS_NEW.yaml', 'w') as file:
    output_file = yaml.dump(tag_dict, file, allow_unicode=True)
