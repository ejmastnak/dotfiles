#!/bin/bash
# NAME
#     normalize-volume - Normalize volume across tracks in an album
# SYNOPSIS
#     normalize-volume.bash opus|mp3|wav
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
if [[ ${1} == "mp3" ]]; then
  loudgain -I3 -S -L -a -k -s e *.mp3 > gaintags.txt
elif [[ ${1} == "opus" ]]; then
  loudgain -a -k -s e *.opus > gaintags.txt
elif [[ ${1} == "wav" ]]; then
  loudgain -I3 -L -a -k -s e *.wav > gaintags.txt
else
  echo "Unrecognized extension: ${1}. Exiting"
fi

# Convert tags into parseable format
awk -F ' ' -v n=4 '/^Track:/ { printf "%s,", $2; for (i = 1; i <= n; i++) getline; print $2}' gaintags.txt > gain.csv

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
rm gaintags.txt gain.csv
