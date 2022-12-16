#!/bin/bash
# NAME
#     normalize-volume - Normalize volume across tracks in an album
# SYNOPSIS
#     normalize-volume.bash opus|mp3
# DESCRIPTION
# Input a set of opus/mp3 files (or any audio file understood by loudgain and
# ffmpeg) with potentially varying sound levels. Output a normalized version of
# each track such that every track now sounds "equally loud".
#
# Dependencies: loudgain, ffmpeg

if [[ "$#" != 1 ]]; then
  echo "Usage: normalize.bash opus|mp3"
  exit 1
fi

# Generate gain tags for album
loudgain -a -k -s e *.${1} > tags.txt

# Convert tags into parseable format
awk -F ' ' -v n=4 '/^Track:/ { printf "%s,", $2; for (i = 1; i <= n; i++) getline; print $2}' tags.txt > gain.csv

# Directory to hold normalized album tracks
output_dir="normalized"
mkdir ${output_dir}

# Adjust audio of each album track
while IFS=, read -r track gain
do
  # Use -nostdin to avoid ffmpeg's interactive prompts when running from a script
  ffmpeg -nostdin -i "${track}" -filter:a "volume=${gain}dB" "${output_dir}/${track}"
done < gain.csv

# Clean-up
rm tags.txt gain.csv
