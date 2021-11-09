#!/bin/sh
# Arguments:
# $1: path to file relative to Vim's current working directory
#     "." if compiled file is in Vim's cwd 
#     "../../directory" (say) for a file outside Vim's cwd
#     final forward slash is intentionally omitted and added manually
# $2: file name without extension
#     e.g. "myfile" if editing myfile.tex
# $3: line number of tex file to show in PDF

/Applications/Skim.app/Contents/SharedSupport/displayline -b -g ${3} "${1}/${2}.pdf" "${1}/${2}.tex" 
