#!/bin/bash
#
# NAME 
#     ambient.bash - Play multiple audio tracks in separate i3 windows
# SYNOPSIS
#     ambient.bash <tracks.csv>
# DESCRIPTION
# For each audio track in tracks.csv, spawns a new terminal window running mpv
# playing the track at the relative volume specified in tracks.csv. Motivation
# is mostly playing overlayed ambient nature sounds and relaxing music in a
# single command, instead of manually opening up new terminals and media player
# instances for each track.

# Usage: 
# Arguments:
#   $1 <tracks.csv> 
#      Path to an CSV file holding at least one (path-to-track,volume) tuple.
#      - `path-to-track` is a path to any audio file understood by mpv.
#      - `volume` is an integer from 0 to 100; this allows playing some tracks
#        louder than others.
# 
#      Example tracks.csv file:
#
#      ```csv
#      # Comments and blank lines are allowed
#      song1.mp3,80
#      louder-song.opus,100
#      folder/quiet-song.wav,50
#      ```

if [[ ${1##*.} != "csv" ]]; then
  echo "Input should be a CSV file."
  exit
fi

i3-msg "split v"
while read line
do
  [[ -z "$line" ]] && continue    # skip blank lines
  [[ $line = \#* ]] && continue   # skip commented lines

  track=${line%%,*}
  volume=${line##*,}

  if [[ -f ${track} ]]; then
    # Note to future self: use alacritty --hold to debug; realpath seems to
    # be necessary for undiscovered reasons. Also: disabling scripts to avoid
    # mpv-cut clogging up screen space and hiding track title, so I can
    # actually see which track is playing in which terminal, but manually
    # loading mpris to allow play-pause.
    i3-msg "exec --no-startup-id alacritty --command mpv --loop=inf --volume="${volume}" --load-scripts=no --script=/etc/mpv/scripts/mpris.so $(realpath "${track}")"
  else
    echo "No file found at ${track}. Skipping."
  fi

done < "${1}"
