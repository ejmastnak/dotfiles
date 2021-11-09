#!/bin/sh

# line=40
# source="$HOME/test/lilypond-book/lilybook.lytex"
# target="$HOME/test/lilypond-book/lilybook-out/lilybook.tex"

line=16
source="$HOME/test/lilypond-book/lilybook-out/lilybook.tex"
target="$HOME/test/lilypond-book/lilybook.lytex"

# output=$(sh lytex-to-tex.sh ${line} "${source}" "${target}")
# echo "${output}"

lytex="$HOME/test/lilypond-book/lilybook.lytex"
tex="$HOME/test/lilypond-book/lilybook-out/lilybook.tex"
pdf="$HOME/test/lilypond-book/lilybook-out/lilybook.tex"

sh lytex-forward-show.sh ${line} "${lytex}" "${tex}" "${pdf}"
