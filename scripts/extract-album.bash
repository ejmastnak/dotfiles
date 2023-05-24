#!/bin/bash
#
# NAME 
#     extract-album.sh - Divide album into individual songs
# SYNOPSIS
#     extract-album.sh <album-file> <timestamp-file>
# DESCRIPTION
# Used to split a single audio file of an entire album into the constituent
# songs.
# Dependencies: ffmpeg, ffprobe

# Usage: 
# Arguments:
#   $1 <album-file> 
#      Path to an audio file holding a complete album
#      in a format that can be understood by ffmpeg.
#      Example: ./my-favorite-things.mp3
# 
#   $2 <timestamp-file>
#      Path to plain text file holding space-separated time stamps
#      and song names in the following format (for example)
#
#      ```
#      # Comments are allowed
#      00:00 My Favorite Things
#      13:43 Everytime We Say Goodbye
#      19:27 Summertime
#      31:03 But Not For Me
#      ```

# Converts input to lowercase and replaces spaces with hyphens
# Example input:  "My Favorite Things"
# Example output: "my-favorite-things"
function to_lowercase() {
  echo "${1}" | sed 's/ /-/g' | awk '{print tolower($0)}'
}

# Get album file extension
extension=${1##*.}

# Get lowercase version of <album-name>, without file extension and with spaces
# replaced by hyphens
output_dir="$(to_lowercase "${1%%.*}")"

mkdir "${output_dir}"

# Read through all lines in timestamp file
line_num=0
while read line
do
  # See docstring of $2 <timestamp-file> for example lines
  [[ -z "$line" ]] && continue    # skip blank lines
  [[ $line = \#* ]] && continue   # skip commented lines
  start_time="$(echo "${line}" | awk '{print $1}')"
  song_name="$(echo "${line}" | cut -f2- -d' ')"
  song_names[${line_num}]="${song_name}"
  start_times[${line_num}]="${start_time}"
  line_num=$((line_num+1))
done < "${2}"
# line_num will now equal number of lines with timestamps

# Duration in HH:MM:SS.MMM format
duration="$(ffprobe -sexagesimal -i "${1}" -show_entries format=duration -v quiet -of csv="p=0")"
# Trimmed duration in HH:MM:SS format
duration=${duration%\.*}

# Loop through all song names and start times
for ((j=0; j < ${line_num}; j++))
do
  # Create M3U playlist
  if [ ${j} -eq 0 ]  # For first song, use '>' to overwrite (possibly) existing M3U file
  then
    echo $(to_lowercase "${song_names[${j}]}.${extension}") > "${output_dir}/${output_dir}.m3u"
  else  # Append songs to existing M3U playlist with '>>'
    echo $(to_lowercase "${song_names[${j}]}.${extension}") >> "${output_dir}/${output_dir}.m3u"
  fi

  # For all songs except last song in playlist, cut using ${start_times}
  if [ ${j} -lt $((line_num-1)) ]  
  then
    ffmpeg -i "${1}" -ss ${start_times[${j}]} -to ${start_times[$((j+1))]} -c copy "${output_dir}/$(to_lowercase "${song_names[${j}]}.${extension}")"

  # For last song in playlist, cut using ${duration}
  else  
    ffmpeg -i "${1}" -ss ${start_times[${j}]} -to ${duration} -c copy "${output_dir}/$(to_lowercase "${song_names[${j}]}.${extension}")"
  fi
done
