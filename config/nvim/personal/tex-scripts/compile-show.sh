#!/bin/sh
# Arguments (1-4 are identical to compile_tex.sh):
# $1: path to file relative to Vim's current working directory
#     "." if compiled file is in Vim's cwd 
#     "../../directory" (say) for a file outside Vim's cwd
#     final forward slash is intentionally omitted and added manually
# $2: file name without extension
#     e.g. "myfile" if editing myfile.tex
# $3: boolean 0/1 controlling latexmk or pdflatex compile
#     1 for latexmk
#     0 for pdflatex (anything other than 1 also works)
# $4: boolean 0/1 controlling shell escape compile
#     1 for shell-escape enabled
#     0 for shell-escape disabled (anything other than 1 also works)
# $5: line number of tex file to show in PDF

sh "${HOME}/.config/nvim/personal/tex-compile-scripts/compile-tex.sh" ${1} ${2} ${3} ${4}
sh "${HOME}/.config/nvim/personal/tex-compile-scripts/forward-show.sh" ${1} ${2} ${5}
