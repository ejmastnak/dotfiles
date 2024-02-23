#!/usr/bin/env python
"""
NAME
    walkandplay.py - Walk through directory and play shuffled media files
SYNOPSIS
    walkandplay.py root_dir/
DESCRIPTION
Input a directory.
Walks through the directory and its children and builds a list of all media
files encountered. Shuffles the list of files, then plays them with mpv.

DEPENDENCIES: mpv
"""

import sys, os, random, subprocess

extension_whitelist = ['opus', 'mp3']

if len(sys.argv) == 2:
    root_dir = sys.argv[1]

if len(sys.argv) > 2:
    print("Error: incorrect number of command line arguments.")
    print("Usage: walkandplay.py root_dir/")
    sys.exit()

media_files = []

# Build up list of media files
for root, dirs, files in os.walk(root_dir):
    for fname in files:
        for ext in extension_whitelist:
            if fname.endswith(ext):
                media_files.append(root + ('' if root == './' else "/") + fname)
                continue

# Shuffle list of media files---done manually as an exercise
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
