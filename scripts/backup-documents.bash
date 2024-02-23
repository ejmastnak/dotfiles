#!/bin/bash
#
# NAME 
#     backup-documents.bash - Backup ~/Documents to cloud storage
# SYNOPSIS
#     backup-documents.bash
# DESCRIPTION
# Uploads ${HOME}/Documents to cloud storage using rclone.

FILTER="${HOME}/.config/rclone/filter.txt"
DOCUMENTS="${HOME}/Documents/"
PASSWORDS="${HOME}/.password-store"
GOOGLE_DOCUMENTS="google-drive:Documents/"
MEGA_DOCUMENTS="mega:Documents/"
MEGA_PASSWORDS="mega:pass/"

rclone sync -v --filter-from "${FILTER}" "${DOCUMENTS}" "${GOOGLE_DOCUMENTS}"
rclone sync -v --filter-from "${FILTER}" "${DOCUMENTS}" "${MEGA_DOCUMENTS}"
rclone sync -v --filter-from "${FILTER}" "${PASSWORDS}" "${MEGA_PASSWORDS}"
