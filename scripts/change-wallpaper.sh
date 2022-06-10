#!/bin/sh
# Sets wallpaper on X display :0 to a random jpg file in my wallpapers directory

directory="minimal-nature"
directory="anime-nature"

DISPLAY=:0 feh --no-fehbg --bg-fill --randomize ~/Pictures/wallpapers/${directory}/*.jpg
