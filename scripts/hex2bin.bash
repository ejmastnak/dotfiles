#!/bin/bash

if [[ "$#" -ne 1 ]]; then
  echo "Usage: hex2bin.bash hex"
  exit 1
fi

# Convert hex to binary and add spaces between bytes
echo "obase=2; ibase=16; ${1}" | bc | sed 's/.\{8\}/& /g'
