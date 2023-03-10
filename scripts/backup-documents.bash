#!/bin/bash
#
# NAME 
#     backup-documents.bash - Backup ~/Documents to cloud storage
# SYNOPSIS
#     ambient.bash
# DESCRIPTION
# Uploads ${HOME}/Documents to cloud storage using rclone.

FILTER="${HOME}/.config/rclone/filter.txt"
LOCAL="${HOME}/Documents/"
GOOGLE="google-drive:Documents/"
MEGA="mega:Documents/"

rclone sync -v --filter-from "${FILTER}" "${LOCAL}" "${GOOGLE}"
rclone sync -v --filter-from "${FILTER}" "${LOCAL}" "${MEGA}"
