#!/bin/bash
# NAME
#     compose-wallpaper.bash - compose word list on wallpaper images
# 
# Used to impose a list of words I want to constantly expose myself to/remend
# myself of on my background wallpapers. The result is I'll see the word list
# on my desktop background.
#
# SYNOPSIS
#     compose-wallpaper.bash

WORDLIST="/home/ej/Documents/pictures/wallpapers/wordlists/2023-q4.txt"
WALLPAPERS_IN="/home/ej/Documents/pictures/wallpapers/anime-nature"
WALLPAPERS_OUT="/home/ej/Documents/pictures/wallpapers/anime-nature-2023-q4"

text="$(< "${WORDLIST}")"

cd ${WALLPAPERS_IN}
for bg_img in *.jpg; do
  echo "${bg_img}"

  # Text image dimensions
  # Goal: text should take up 1920px/3 - 10px/2 after scaling to 1920px
  # (1/3rd 1920px monitor width minus half of 10px i3 gaps)
  X_RAW=`identify -format "%w" ${bg_img}`
  X_TARGET="635"  # 1920/3 - 10/2
  X=$((${X_TARGET} * ${X_RAW} / 1920))  # scale by image width/1920
  Y=`identify -format "%h" ${bg_img}`

  compose-text-and-image.bash "${text}" "${bg_img}" "${WALLPAPERS_OUT}/${bg_img%%.jpg}.png" ${X} ${Y}

done;
