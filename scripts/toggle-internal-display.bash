#!/bin/bash
# NAME
#     toggle-internal-display.bash - Toggles laptop's internal display
# 
# SYNOPSIS
#     toggle-internal-display.bash
#
# DESCRIPTION
# Toggles laptop's built-in display as a safeguard against turning it off and
# having no easy way to turn it back on without visual feedback.

internal=eDP-1
internal_device="card1-eDP-1"

if [ $(cat /sys/class/drm/${internal_device}/enabled) == "enabled" ]; then
  xrandr --output ${internal} --off
else
  xrandr --output ${internal} --auto
fi
