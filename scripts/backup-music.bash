#!/bin/bash
#
# NAME 
#     backup-music.bash - Backup music library to cloud storage
# SYNOPSIS
#     backup-music.bash

FILTER="${HOME}/.config/rclone/music-filter.txt"
LOCAL="${HOME}/Music/library/"
REMOTE="music:Music"

rclone sync -v --filter-from "${FILTER}" "${LOCAL}" "${REMOTE}"
