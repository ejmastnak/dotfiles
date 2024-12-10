#!/bin/bash
# NAME
#     5mates.bash - Creates a 5MATEs reminder wallpaper 
#
# DESCRIPTION
#     Chooses a task or exercise at random from current 5MATES list, chooses a
#     wallpaper at random, and superimposes task/exercise text on wallpaper.

LIST=~/Documents/projects/5mates/list.md
WALLPAPERS_IN=~/Documents/pictures/wallpapers/anime-nature
OUTPUT_IMG=~/Documents/pictures/wallpapers/current

# Pick a 5MATE at random
text=`shuf -n 1 ${LIST}`

# Pick a background wallpaper at random
bg_wallpaper=`find ${WALLPAPERS_IN} -type f -name "*.jpg" | shuf -n 1`

# Create wallpaper
compose-text-and-image.py "${text}" "${bg_wallpaper}" ${OUTPUT_IMG}

# Change wallpaper
DISPLAY=:0 feh --no-fehbg --bg-fill ${OUTPUT_IMG}
