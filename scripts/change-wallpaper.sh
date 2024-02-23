#!/bin/sh
# Sets wallpaper on X display :0 to a random jpg file in my wallpapers directory

WALLPAPERS="${HOME}/Documents/pictures/wallpapers/active"

# Redirect warnings about missing png/jpg files if none are present
DISPLAY=:0 feh --no-fehbg --bg-fill --randomize "${WALLPAPERS}/"*.{png,jpg} 2> /dev/null
