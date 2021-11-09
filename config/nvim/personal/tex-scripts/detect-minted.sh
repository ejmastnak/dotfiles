#!/bin/sh
# Usage: sh detect-minted.sh filename
# Argument $1: the tex file to search

# This script detects if a tex file contains the string
#  "minted" somewhere in the preamble (i.e. before reaching \begin{document})
# 
# Goal: Determine if the tex document uses the minted package and should thus 
#  be compiled using the -shell-escape option enabled

sed '/\\begin{document}/q' "${1}" | grep "minted" > /dev/null
