#!/bin/sh
# NAME
#     volume-alsa - Increase/decrease/mute volume using ALSA's amixer
# SYNOPSIS
#     volume-alsa <raise|lower|mute|mute-mic>

step=5  # number of percentage points to increase/decrease volume

if [ $1 == "raise" ]; then
  amixer set Master ${step}%+ > /dev/null
  pkill -RTMIN+10 i3blocks
elif [ $1 == "lower" ]; then
  amixer set Master ${step}%- > /dev/null
  pkill -RTMIN+10 i3blocks
elif [ $1 == "mute" ]; then
  amixer set Master toggle > /dev/null
  pkill -RTMIN+10 i3blocks
elif [ $1 == "mute-mic" ]; then
  amixer set Capture toggle > /dev/null
  pkill -RTMIN+10 i3blocks
else
  echo "Unrecognized parameter: ${1}"
  echo "Usage should be: volume-alsa <raise|lower|mute|mute-mic>"
fi
