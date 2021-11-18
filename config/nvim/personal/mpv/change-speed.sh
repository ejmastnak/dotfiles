#!/bin/sh
# This script is used increase or decrease, via JSON-based IPC, 
# the current playback speed of a video being played with mpv.
# Arguments:
# $1: path to the Unix domain socket used for communication
#     between mpv and external programs
#     e.g. "/tmp/mpvsocket"
# $2: Determines whether to speed up or slow down
#     - "faster" to speed up 
#     - "slower" to slow down
#     - "reset" to set speed to 1

# # get current playback rate
speed=$(echo '{ "command": ["get_property", "speed"] }' | socat - "${1}" | jq ".data")

# Explanation
# The echo command echos the string IPC query 
# '{ "command": ["get_property", "speed-time"] }', via socat,
# to the Unix domain socket passed as the shell script's first argument.

# The socat call returns a JSON output of the form (for example)
# {"data":1.464100,"request_id":0,"error":"success"}.

# The jq '.data' command reads the attribute 'data', which holds the desired 
# playback speed, from the socat command's output. 
# The jq command outputs a dimensionless decimal number e.g. 1.464100

if [ ${2} == "faster" ]
then  # increase speed by 10% of current value  
  speed=$(echo "scale=6;${speed}*1.1" | bc)
elif [ ${2} == "slower" ]
then  # decrease speed by 10% of current value
  speed=$(echo "scale=6;${speed}/1.1" | bc)
elif [ ${2} == "reset" ]
then  # change speed to one
  speed="1.00"
else
  echo "Unrecognized second argument: ${2}"
  exit 1
fi

echo "{ \"command\": [\"set_property\", \"speed\", \"${speed}\"] }" | socat - "${1}"
