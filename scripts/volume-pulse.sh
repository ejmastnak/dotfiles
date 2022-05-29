#!/bin/sh
# NAME
#     volume-pulse - Increase/decrease/mute volume using PulseAudio's pactl
# SYNOPSIS 
#     volume-pulse <raise|lower|mute|mute-mic>

step=5   # number of percentage points to increase/decrease volume
max=100  # do not increase volume above this value

# Print current volume as an integer number representing percent of max volume
function get_current_volume() {
  pactl get-sink-volume @DEFAULT_SINK@ | awk -F '/' '{print $2}' | grep -o '[0-9]\+'
}

if [ $1 == "raise" ]; then
  if [ `get_current_volume` -lt ${max} ]; then
    pactl set-sink-volume @DEFAULT_SINK@ "+${step}%"
  fi
  pkill -RTMIN+10 i3blocks
elif [ $1 == "lower" ]; then
  pactl set-sink-volume @DEFAULT_SINK@ "-${step}%"
  pkill -RTMIN+10 i3blocks
elif [ $1 == "mute" ]; then
  pactl set-sink-mute @DEFAULT_SINK@ toggle
  pkill -RTMIN+10 i3blocks
elif [ $1 == "mute-mic" ]; then
  pactl set-source-mute @DEFAULT_SOURCE@ toggle
  pkill -RTMIN+10 i3blocks
else
  echo "Unrecognized parameter: ${1}"
  echo "Usage should be: volume-pulse <raise|lower|mute|mute-mic>"
fi
