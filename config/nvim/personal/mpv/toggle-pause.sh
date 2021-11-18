#!/bin/sh
# This script is used to set, via JSON-based IPC, the play/pause state of
# a video being played with mpv.
# 
# Arguments:
# $1: path to the Unix domain socket used for communication
#     between mpv and external programs
#     e.g. "/tmp/mpvsocket"

# query video's current pause_state, which should be either "true" or "false"
pause_state=$(echo '{ "command": ["get_property", "pause"] }' | socat - "${1}" | jq ".data")

if [ ${pause_state} == "true" ]
then  # if video is paused, play it
  echo '{ "command": ["set_property", "pause", false] }' | socat - "${1}"
elif [ ${pause_state} == "false" ]
then  # if video is playing, pause it
  echo '{ "command": ["set_property", "pause", true] }' | socat - "${1}"
else
  echo "Error detecting video's play/pause state."
  exit 1
fi
