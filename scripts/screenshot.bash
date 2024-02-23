#!/bin/bash
# NAME
#     screenshot - Take a screenshot using `maim`
# SYNOPSIS 
#     screenshot [-r|-s]
#
# OPTIONS
# -r  takes a screenshot of root window (default)
# -s  select region to screenshot using `slop`

ROOT=1
SELECT=2

# Screenshot the root window by default
method=${ROOT}

# Use timestamp to ensure unique filename
output="${HOME}/Documents/pictures/cap-$(date +%Y-%m-%d-%S-%N).png"

while getopts ":rs" flag
do
  case "${flag}" in
    r) method=${ROOT};;
    s) method=${SELECT};;
    \?) # Invalid option
      echo "Error: Invalid option"
      exit;;
  esac
done

if  [[ ${method} -eq ${ROOT} ]]; then
  maim "${output}"
elif  [[ ${method} -eq ${SELECT} ]]; then
  maim -s "${output}"
else
  echo "Error: unrecognized screenshot method: ${method}"
fi
