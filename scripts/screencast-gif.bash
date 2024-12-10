#!/bin/bash
# NAME
#     screenrec - GIF or APNG screen recording using `menyoki`
# SYNOPSIS 
#     screenshot [-s|-a|-g|-k]
#
# OPTIONS
# -s  select region to screenshot using `slop` (default)
# -r  record entire screen
# -g  record in GIF format (default)
# -a  record in APNG format
# -k  record in APNG format

# Use GIF by default
format="gif"

# Screenkey off by default
keys=0

ROOT=1
SELECT=2

# Screenshot the root window by default
method=${SELECT}

while getopts ":srgak" flag
do
  case "${flag}" in
    g) format="gif";;
    a) format="apng";;
    r) method=${ROOT};;
    s) method=${SELECT};;
    k) keys=1;;
    \?) # Invalid option
      echo "Error: Invalid option"
      exit;;
  esac
done

# Use timestamp to ensure unique filename
output="${HOME}/Pictures/cap-$(date +%Y-%m-%d-%S-%N).${format}"

# Build up command based on passed command line flags
command="menyoki record --root"

# Set region of screen to capture
if [[ ${method} -eq ${SELECT} ]]; then
  geometry=$(slop)
  command="${command} --size ${geometry}"
fi

# Set recording format
if [[ ${format} == "apng" ]]; then
  command="${command} apng"
else
  command="${command} gif --gifski"
fi

# Set output file
command="${command} save ${output}"

# Start screenkey, if relevant
if [[ ${keys} -eq 1 ]]; then
  screenkey_cmd="screenkey --font \"Source Code Pro Bold\" --bg-color '#81a1c1' --font-color '#eceff4'"
  if [[ ${method} -eq ${SELECT} ]]; then
    screenkey_cmd="${screenkey_cmd} --geometry ${geometry}"
  fi

  # Execute screenkey command and grab PID
  eval "${screenkey_cmd} &"
  screenkey_pid=${!}
fi

# Execute screen recording command
${command}

kill ${screenkey_pid}
