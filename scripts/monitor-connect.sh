#!/bin/bash
# Used to turn external display on and internal display off

internal=eDP-1
external=HDMI-1

# Turn external display on
xrandr --output ${external} --auto

# Turn internal display off
xrandr --output ${internal} --off
