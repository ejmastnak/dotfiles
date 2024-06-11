#!/usr/bin/env python
"""
NAME
    shuffle-and-play.py - Shuffle and play media in playlist or child
    directories.

SYNOPSIS
    shuffle-and-play.py [root_dir]
    shuffle-and-play.py playlist.m3u[8]

DESCRIPTION
    Input path to a directory or M3U playlist. 
    If no arguments are provided, the current working directory is used.
    For a directory, recursively finds all media files in the directory and
    its child directories, shuffles these media files, and plays them with mpv.
    For a playlist, shuffles the playlist's contents, and plays them with mpv.

DEPENDENCIES: mpv
"""

import sys, os, random, subprocess
from pathlib import Path

media_files = []

def shuffle_directory(root_dir):
    extension_whitelist = ['opus', 'mp3']
    for root, dirs, files in os.walk(root_dir):
        for fname in files:
            for ext in extension_whitelist:
                if fname.endswith(ext):
                    media_files.append(root + ('' if root == './' else "/") + fname)
                    continue
    _shuffle_and_play(media_files)


def shuffle_playlist(playlist):
    with open(playlist) as file:
        for line in file:
            track = line.strip()
            if not track or track.startswith('#'):
                continue
            media_files.append(track)
    _shuffle_and_play(media_files)


def _shuffle_and_play(media_files):
    # Shuffling done manually as an exercise
    N = len(media_files)
    for i, file in enumerate(media_files):
        idx = random.randrange(i, N)
        # Exchange media_files[idx] and media_files[i]
        tmp = media_files[idx]
        media_files[idx] = media_files[i]
        media_files[i] = tmp

    output_string = subprocess.run(
            ["mpv", "--playlist=-"],
            input="\n".join(media_files),
            text=True,
            )


if __name__ == "__main__":
    try:
        if len(sys.argv) == 1:
            shuffle_directory("./")
        elif len(sys.argv) == 2 and Path(sys.argv[1]).is_dir():
            shuffle_directory( sys.argv[1])
        elif len(sys.argv) == 2 and Path(sys.argv[1]).is_file() and (sys.argv[1].endswith("m3u") or sys.argv[1].endswith("m3u8")):
            shuffle_playlist( sys.argv[1])
        else:
            print("Error: incorrect number of command line arguments.")
            print("Usage:\n\tshuffle-and-play.py [root_dir]\n\tshuffle-and-play.py playlist.m3u")
            sys.exit()
    except KeyboardInterrupt:
        sys.exit("Exiting")

