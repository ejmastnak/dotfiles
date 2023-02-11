#!/bin/bash
# NAME
#     volume-normalize.bash - Normalize volume across tracks in an album
# SYNOPSIS
#     volume-normalize.bash opus|mp3|wav
# DESCRIPTION
# Input a set of opus/mp3/wav files (or any audio file understood by loudgain
# and ffmpeg) with potentially varying sound levels. Output a normalized version of
# each track such that every track now sounds "equally loud".
#
# Note: this script creates *new* tracks with the actual audio data changed.
# I.e. the script creates a re-encoded copy of each input track.
# The use case is e.g. preparing files for burning to CD where the CD player
# wouldn't understand replaygain metadata.
#
# TBH I'm not sure if the script also writes gain tags to the original file.
# I'd assume it does because loudgain should do just that, but then e.g. 
# id3info doesn't show any replaygain tags so blah IDK.
#
# Dependencies: loudgain, ffmpeg

if [[ "$#" != 1 ]]; then
  echo "Usage: volume-normalize.bash opus|mp3|wav"
  exit 1
fi

# Generate gain tags for album from RECOMMENDATIONS in `man loudgain`.
echo "Scanning album files to determine track gain."
if [[ ${1} == "mp3" ]]; then
  loudgain -I3 -S -L -a -k -s e *.mp3 > gaintags.txt
elif [[ ${1} == "opus" ]]; then
  loudgain -a -k -s e *.opus > gaintags.txt
elif [[ ${1} == "wav" ]]; then
  loudgain -I3 -L -a -k -s e *.wav > gaintags.txt
else
  echo "Unrecognized extension: ${1}. Exiting"
fi

# Convert tags into parseable format, e.g. from
#
# Track: is-this-love.mp3
# Loudness:   -11.87 LUFS
# Range:        6.60 dB
# Peak:     1.115354 (0.95 dBTP)
# Gain:        -6.13 dB
#
# to... `is-this-love.mp3,-6.13`
awk -F ' ' -v n=4 '/^Track:/ { printf "%s,", $2; for (i = 1; i <= n; i++) getline; print $2}' gaintags.txt > gain.csv

# Directory to hold normalized album tracks
output_dir="normalized"
mkdir ${output_dir}

# Adjust audio of each album track
echo "Adjusting volume of tracks."
while IFS=, read -r track gain
do
  # Use -nostdin to avoid ffmpeg's interactive prompts when running from a script
  ffmpeg -nostdin -i "${track}" -filter:a "volume=${gain}dB" "${output_dir}/${track}"
done < gain.csv

# Clean-up
rm gaintags.txt gain.csv
