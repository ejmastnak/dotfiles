#!/bin/sh
# This script is used to seek through a video being played with mpv
# using JSON-based IPC. Currently performs relative seeks, i.e. seek
# relative to current playback position.
# 
# Arguments:
# $1: path to the Unix domain socket used for communication
#     between mpv and external programs
#     e.g. "/tmp/mpvsocket"
# $2: number of seconds to seek
#     e.g. "60" for one minute forward
#     e.g. "-30" for thirty seconds backward

# Use keyframe (and not exact) seek for times larger than 60 seconds
# Check if abs(${2}) is greater than 120 seconds (say).
# ${2#-} removes a possible prepending '-' sign from ${2},
# which is equivalent to abs(${2})
if [ ${2#-} -gt "60" ]
then
  echo "{ \"command\": [\"seek\", \"${2}\", \"relative\", \"keyframes\"] }" | socat - "${1}"
else
  echo "{ \"command\": [\"seek\", \"${2}\", \"relative\", \"exact\"] }" | socat - "${1}"
fi
