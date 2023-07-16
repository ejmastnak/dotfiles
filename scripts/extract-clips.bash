#!/bin/bash
#
# NAME 
#     extract-clips.bash - Extract clips from an audio or video track
# SYNOPSIS
#     extract-clips.bash source-file timestamps.txt
# DESCRIPTION
# Used to split a single audio or video track into multiple clips using a
# provided timestamp file
# Dependencies: ffmpeg

# Arguments:
#   $1 source-file 
#      Path to an audio or video file in a format that can be understood by
#      ffmpeg.
#      Example: ./my-favorite-things.mp3
# 
#   $2 timestamp-file
#      Path to plain text file holding clip names and timestamps in the
#      following format (for example)
#
#      ```
#      # Comments and blank lines are allowed
#      foo 00:00:26.493 00:00:33.333
#
#      bar 00:00:20.087 00:00:26.793
#      baz 00:00:26.493 00:00:33.333
#      ```

if [[ "$#" != 2 ]]; then
  echo "Usage: extract-clips.bash source-file timestamps.txt"
  exit 1
fi


# Get source file's extension
extension=${1##*.}

# Use source file's basename as output directory for clips
output_dir="${1%.*}"
mkdir -p "${output_dir}"

# Read through all lines in timestamp file
while read -r clip_name from to remainder
do
  [[ -z ${clip_name} ]] && continue     # skip blank lines
  [[ ${clip_name} = \#* ]] && continue  # skip commented lines

  ffmpeg -y -ss ${from} -to ${to} -i ${1} -c copy "${output_dir}/${clip_name}.${extension}" < /dev/null
  
done < "${2}"

exit
