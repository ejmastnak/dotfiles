#!/usr/bin/env python

#
# NAME 
#     playlist-duration.py - Compute duration of a M3U playlist
# SYNOPSIS
#     playlist-duration.py playlist.m3u
#
# `playlist.m3u` should be a M3U playlist with one path to a track per line.
# Comments beginning with `#` and blank lines are allowed.
#
# Dependencies: ffmpeg, ffprobe

import subprocess
import sys
from pathlib import Path

def seconds_to_hhmmss(seconds):
    hours = seconds // 3600
    minutes = (seconds % 3600) // 60
    seconds = seconds % 60
    return f"{hours:02}:{minutes:02}:{seconds:02}"

def get_track_duration(track_file):
    if not Path(track_file).is_file():
        print(f"Error: {track_file} does not exist or is not a regular file.")
        return 0.0
    try:
        result = subprocess.run(
                ['ffprobe', '-v', 'quiet', '-of', 'csv=p=0', '-show_entries', 'format=duration', track_file],
                capture_output=True, text=True
                )
        return float(result.stdout.strip())
    except Exception as e:
        print(f"Error getting duration for {track_file}: {e}")
        return 0.0

def main(playlist_file):
    total_duration = 0.0
    with open(playlist_file, 'r') as file:
        for line in file:
            track = line.strip()
            # Skip commented or blank lines
            if not track or track.startswith('#'):
                continue
            track_duration = get_track_duration(track)
            total_duration += track_duration
            print(f"{seconds_to_hhmmss(int(track_duration))} {track}")

    print("---------------------------")
    print(f"{seconds_to_hhmmss(int(total_duration))} Playlist")

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python playlist-duration.py playlist.m3u")
        sys.exit(1)
    main(sys.argv[1])
