#!/bin/bash
# Used to turn external display on and internal display off

internal=eDP-1
external=HDMI-1

# Turn internal display on
xrandr --output ${internal} --auto

# Turn external display off
xrandr --output ${external} --off

