#!/bin/bash
#
# NAME 
#     ambient.bash - Play multiple audio tracks simultaneously with mpv
# SYNOPSIS
#     ambient.bash <tracks-to-play.csv>
# DESCRIPTION
# Plays multiple audio tracks simultaneously using multiple instances of mpv
# running in the background. Motivation is mostly playing overlayed ambient
# nature sounds and relaxing music in a single command, instead of using a
# separate shell for each track.

# Usage: 
# Arguments:
#   $1 <tracks-to-play.csv> 
#      Path to an CSV file holding at least one
#      (path-to-track,relative-volume) tuple.
#      `path-to-track` is a path to any track understood by mpv
#      `relative-volume` is an integer from 0 to 100;
#      this allows playing some tracks louder than others.
# 
#      ```
#      # Comments and blank lines are allowed
#      song1.mp3,80
#      louder-song.opus,100
#      folder/quiet-song.wav,50
#      ```

# Read through all lines in tracks-to-play.csv
line_num=0
while read line
do
  # See docstring of $2 <timestamp-file> for example lines
  [[ -z "$line" ]] && continue    # skip blank lines
  [[ $line = \#* ]] && continue   # skip commented lines

  track=${line%%,*}
  volume=${line##*,}

  mpv --volume="${volume}" "${track}" &
  track_pid=$!
  printf "[${track_pid}]\t${track}\n"

done < "${1}"

# Give time for mpv output to appear on stdout
sleep 0.5
