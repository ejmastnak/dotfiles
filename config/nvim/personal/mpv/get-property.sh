#!/bin/sh
# This script is used for debugging purposes to view the current values
# of MPV properties for a video being played with mpv.
# 
# Arguments:
# $1: path to the Unix domain socket used for communication
#     between mpv and external programs
#     e.g. "/tmp/mpvsocket"
# $2: A valid MPV property

echo "{ \"command\": [\"get_property\", \"${2}\"] }" | socat - "${1}"
echo "{ \"command\": [\"get_property\", \"${2}\"] }" | socat - "${1}" | jq ".data"
