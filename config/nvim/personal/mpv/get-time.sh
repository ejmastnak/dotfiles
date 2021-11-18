#!/bin/sh
# This script is used to get, via JSON-based IPC, the current time 
# of a video being played with mpv.
# Arguments:
# $1: path to the Unix domain socket used for communication
#     between mpv and external programs
#     e.g. "/tmp/mpvsocket"

# echo '{ "command": ["get_property", "playback-time"] }' | socat - "${1}" | jq ".data"

seconds=$(echo '{ "command": ["get_property", "playback-time"] }' | socat - "${1}" | jq ".data")

# Explanation
# The echo command echos the string IPC query 
# '{ "command": ["get_property", "playback-time"] }', via socat,
# to the Unix domain socket passed as the shell script's first argument.

# The socat call returns a JSON output of the form (for example)
# {"data":5.680000,"request_id":0,"error":"success"}.

# The jq '.data' command reads the attribute 'data', which holds the desired 
# playback time, from the socat command's output. The jq command outputs a
# time in units of seconds, e.g. 1323.32 or 5.32

# Example: seconds is originally 3212.94
# mmm=${seconds#*.}       # mmm becomes 94
seconds=${seconds%%.*}  # seconds changes from 3212.94 to 3212

h=$(( seconds / 3600 ))
m=$(( ( seconds / 60 ) % 60 ))
s=$(( ${seconds} % 60 ))

printf "%02d:%02d:%02d\n" ${h} ${m} ${s}
