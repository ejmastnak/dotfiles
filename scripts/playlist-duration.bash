#!/bin/bash
#
# NAME 
#     playlist-duration.bash - Print duration of an playlist
# SYNOPSIS
#     playlist-duration.bash playlist.m3u
#
# playlist.m3u should be a simple M3U playlist with one path to a track per line.
#
# Dependencies: ffmpeg, ffprobe
#

# Input seconds, possibly in decimal form
seconds_to_hhmmss() {
  seconds=${1%.*}
  h=$(( seconds / 3600 ))
  m=$(( ( seconds / 60 ) % 60 ))
  s=$(( ${seconds} % 60 ))

  printf "%02d:%02d:%02d\n" ${h} ${m} ${s}
}

duration="0.0"

# Read through all lines in playlist file
line_num=0
while read track
do
  # See docstring of $2 <timestamp-file> for example lines
  [[ -z "${track}" ]] && continue    # skip blank lines
  [[ ${track} = \#* ]] && continue   # skip commented lines

  track_duration="$(ffprobe -v quiet -of csv=p=0 -show_entries format=duration ${track})"

  # Increment playlist duration
  duration=$(bc <<< "${duration}+${track_duration}")

  # Print duration of each track
  echo "$(seconds_to_hhmmss ${track_duration}) ${track}"
  
done < "${1}"

echo "---------------------------"
echo "$(seconds_to_hhmmss ${duration}) Playlist"
