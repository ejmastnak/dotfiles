#!/bin/sh
# Script for compiling LaTeX files.
# The script basically builds up a command string and then executes ${command} "myfile.tex"

# Arguments:
# $1: path to file's parent directory relative to Vim's current working directory
#     "." if compiled file is in Vim's cwd 
#     "../../directory" for a file outside Vim's cwd
#     final forward slash after "directory" is intentionally omitted and added manually
# $2: file name with but without path
#     e.g. "myfile.tex" if editing myfile.tex
# $3: boolean 0/1 controlling latexmk or pdflatex compile
#     1 for latexmk
#     0 for pdflatex (anything other than 1 also works)
# $4: boolean 0/1 controlling shell escape compile
#     1 for shell-escape enabled
#     0 for shell-escape disabled (anything other than 1 also works)

# # Debugging
# echo "Printing compile.sh arguments..."
# echo "${1}"
# echo "${2}"
# echo "${3}"
# echo "${4}"
# echo "End compile.sh arguments"
# echo ""

# most latexmk options are already specified in ~/.config/latexmkrc
latexmk_options="-pdf -output-directory=${1}"
pdflatex_options="-file-line-error -interaction=nonstopmode -halt-on-error -synctex=1 -output-dir=${1}"

# test for compilation with latexmk
# --------------------------------------------- #
if [ ${3} -eq 1 ]  # use latexmk
then
  command="latexmk ${latexmk_options}"
else  # use pdflatex
  command="pdflatex ${pdflatex_options}"
fi
# --------------------------------------------- #

# append -shell-escape option if ${4} == 1
[ ${4} -eq 1 ] && command="${command} -shell-escape"

# run the compilation command
${command} "${1}/${2}"
