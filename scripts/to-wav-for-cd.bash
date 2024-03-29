#!/bin/bash
# NAME
#     to-wav-for-cd.bash - Convert album tracks to CD-playable format
# SYNOPSIS
#     to-wav-for-cd.bash playlist.m3u
# DESCRIPTION
# Input an M3U playlist file containing the paths to the album tracks, e.g.
# 
#   # File SAX.m3u
#   saxophone/gerald-albright/in-the-moment.mp3
#   saxophone/gerald-albright/better-days-ahead.mp3
#   saxophone/gerald-albright/g-and-lee.mp3
#
# Outputs the album files converted to 16-bit, 44100-Hz, stereo WAV files
# numbered in the order they appeared in the M3U playlist, into a directory
# whose name is the basename of the M3U playlist file, e.g.
#
#   # to-wav-for-cd.bash SAX.m3u` produces
#   SAX/01-in-the-moment.wav
#   SAX/02-better-days-ahead.wav
#   SAX/03-g-and-lee.wav
#
# Dependencies: mpg123 (for mp3 files), opusdec (for opus files)

if [[ "$#" != 1 ]]; then
  echo "Usage: to-wav-for-cd.bash playlist.m3u"
  exit 1
fi

album_dir="$(basename "${1}" .m3u)"
mkdir "${album_dir}"
i=1

while read track
do
  # Ignore blank lines and commented lines
  [[ -z "${track}" ]] && continue
  [[ "${track}" = \#* ]] && continue
  
  # Extract "mp3" and "bar" from "foo/bar.mp3"
  ext=${track##*.}
  basename="$(basename "${track}" .${ext})"

  # Decode files to WAV; output into album directory
  if [[ ${ext} == "mp3" ]]; then
    mpg123 --rate 44100 --stereo --buffer 3072 --resync -w "${album_dir}/$(printf %02d $i)_${basename}.wav" "${track}"
    ((i++))
  elif [[ ${ext} == "opus" ]]; then
    opusdec --rate 44100 "${track}" "${album_dir}/$(printf %02d $i)_${basename}.wav"
    ((i++))
  else
    echo "Unrecognized extension: ${1}. Skipping track."
  fi
  
done < "${1}"
