#!/bin/sh
# Arguments:
# $1: line number in LYTEX file for forward show
# $2: path to LYTEX FILE relative to Vim's cwd
# $3: path to TEX FILE relative to Vim's cwd
# $4: path to PDF FILE relative to Vim's cwd
# $5: operating system name as returned by uname
#     i.e. "Darwin" on macOS and "Linux" on Linux

# echo "LYTEX line: ${1}"
# echo "LYTEX file: ${2}"
# echo "TEX file: ${3}"
# echo "PDF file: ${4}"
# echo "OS: ${5}"

lytex_to_tex_script="$HOME/.config/nvim/personal/lilypond-scripts/lytex-to-tex.sh"

# get line in TEX file corresponding to inputted line in LYTEX file
tex_line=$(sh "${lytex_to_tex_script}" ${1} "${2}" "${3}")

if [ ${5} = "Darwin" ]  # macOS
then
  /Applications/Skim.app/Contents/SharedSupport/displayline -b -g ${tex_line} "${4}" "${3}"
else  # Linux/other
  echo "OS not yet supported!"
fi

