#!/bin/bash
#
# NAME 
#     ambient-tmux.bash - Play multiple audio tracks in separate tmux panes
# SYNOPSIS
#     ambient-tmux.bash <mix.csv>
# DESCRIPTION
# For each audio track in mix.csv, spawns a new tmux pane running mpv
# playing the track at the relative volume specified in mix.csv.
# Motivation: mostly playing overlayed ambient nature sounds and relaxing music
# in a single command, instead of manually opening up new terminals and media
# player instances for each track.

# Check if a file path is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: ${0} mix.csv"
    exit 1
fi

TMUX_SESSION_NAME="mix"

csv_file="${1}"

tmux new-session -d -s ${TMUX_SESSION_NAME} 2>/dev/null || true

cleanup_and_exit() {
    tmux kill-session -t mix
    exit 1
}

# Trap CTRL+C (SIGINT) so we can clean up properly
trap cleanup_and_exit SIGINT

# Read the CSV file
while IFS=, read -r track volume; do
    # Skip empty lines and comments
    if [[ -z "$track" ]] || [[ "$track" =~ ^#.* ]]; then
        continue
    fi
    
    # Create a new tmux pane and play the track. Close pane when mpv exits.
    tmux split-window -v "mpv --loop=inf --volume=${volume} \"${track}\"; tmux kill-pane"

done < "${csv_file}"

# # Rearrange panes so all panes remain visible
# tmux select-layout tiled > /dev/null

# Once done setting up, attach to the session
tmux attach-session -t mix
