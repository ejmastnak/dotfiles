#!/bin/sh
# This script helps implement forward search from a *.tex source file to PDF reader
# Arguments:
# $1: path to file relative to Vim's current working directory
#     "." if compiled file is in Vim's cwd 
#     "../../directory" (say) for a file outside Vim's cwd
#     final forward slash is intentionally omitted and added manually
# $2: file name without extension
#     e.g. "myfile" if editing myfile.tex
# $3: line number of tex file to show in PDF
#     e.g. 42
# $4: operating system name as returned by uname
#     i.e. "Darwin" on macOS and "Linux" on Linux

if [ ${4} = "Darwin" ]  # macOS
then
  /Applications/Skim.app/Contents/SharedSupport/displayline -b -g ${1} "${2}" "${3}" 
else  # Linux/other
  echo "OS not yet supported!"
fi
