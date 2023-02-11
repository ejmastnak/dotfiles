#!/usr/bin/env python
"""
NAME
    tag-tracks.py - Add ID3 tags from supplied tag file
SYNOPSIS
    tag-tracks.py tagfile.yaml
DESCRIPTION
Input a YAML file (format below) with ID3 tag information for a set of tracks.
Uses pytaglib (a wrapper around taglib) to add the ID3 tags to the tracks.

Expects an inputted tagfile.yaml file with the following form:

aprietala-en-el-rincon.opus:  # path to track
  title: Aprietala En El Rincon
  artist: Papaito
  album: Papaito
  year: 1980

Assumes the `title`, `artist`, `album` and `year` keys are defined for every
track; will fail ungracefully if they are not---no error checking is
implemented for these keys.

"""
import sys, yaml, taglib, subprocess

if len(sys.argv) != 2:
    print("Error: incorrect number of command line arguments.")
    print("Usage: tag-tracks.py tag-file.yaml")
    sys.exit()

tagfile = sys.argv[1]
    
with open(tagfile, "r") as stream:
    try:
        tag_dict = yaml.safe_load(stream)
    except yaml.YAMLError as exc:
        print("Error reading file.")
        print(exc)
        sys.exit()

for track_file in tag_dict:
    title = tag_dict[track_file]["title"]
    artist = tag_dict[track_file]["artist"]
    album = tag_dict[track_file]["album"]
    year = tag_dict[track_file]["year"]

    print(track_file)

    # track = taglib.File(track_file)
    # track.tags["TITLE"] = [title]
    # track.tags["ARTIST"] = [artist]
    # track.tags["ALBUM"] = [album]
    # track.tags["YEAR"] = [str(year)]
    # track.save()

    subprocess.run(["id3tag",
                    "--song", title,
                    "--artist", artist,
                    "--album", album,
                    "--year", str(year),
                    track_file])
