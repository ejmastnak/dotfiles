#!/usr/bin/env python
"""
NAME 
    download-facebook.py - Download a video from Facebook
SYNOPSIS
    download-facebook.py urls.txt [output.mp4]
DESCRIPTION
    Input a two-line text file of the form:
    
      https://video-lga3-2.xx.fbcdn.net/v/stuff/&bytestart=foo&byteend=bar
      https://video-lga3-2.xx.fbcdn.net/v/stuff/&bytestart=foo&byteend=bar

    I.e. with URLs to audio and video stream. The script merges the audio and
    video streams into a single mp4 file.
"""

import sys, subprocess
from pathlib import Path

if (len(sys.argv) < 2 or len(sys.argv) > 3):
    print("Error: incorrect number of command line arguments.")
    print("Usage: download-facebook.py urls.txt [output.mp4]")
    sys.exit()

# Read into an array.
# Remove blank and commented lines.
# Only continue if array is two-element
# Use larger-smaller file size heuristic

lines = []
with open(sys.argv[1]) as file:
    for line in file:
        line = line.rstrip()
        # Skip empty or commented lines
        if line.startswith("#") or len(line) == 0: continue
        lines.append(line)

if len(lines) != 2:
    print("Error: The URL file must contain exactly two lines—one for audio data and one for video data.")
    sys.exit()
    
urls = []
for line in lines:
    idx = line.rfind("&bytestart")
    urls.append(line if idx == -1 else line[:idx])

stream1 = "stream1.mp4"
stream2 = "stream2.mp4"
output = "output.mp4"

subprocess.run(["curl", urls[0], "--output", stream1])
subprocess.run(["curl", urls[1], "--output", stream2])

# ffmpeg -i "stream1.mp4" -i "stream2.mp4" -c:v copy -c:a aac output.mp4
subprocess.run([
    "ffmpeg",
    "-i",
    stream1,
    "-i",
    stream2,
    "-c:v",
    "copy",
    "-c:a",
    "aac",
    output
])

# Clean up
p1 = Path(stream1)
p1.unlink()
p2 = Path(stream2)
p2.unlink()
