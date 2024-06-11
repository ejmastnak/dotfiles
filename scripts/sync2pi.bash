#!/bin/bash
# Syncs music and audio to Raspberry Pi

# Check if a host is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: ${0} host"
    exit 1
fi


SOURCE="${HOME}/Music/library/"
SSH_KEY="${HOME}/.ssh/Pi_id_ed25519"
WHITELIST="${SOURCE}/whitelist-rsync-pi.conf"
HOST="${1}"
HOST_USER="pi"
DESTINATION="/home/${HOST_USER}/Music/library/"

rsync \
  -avz \
  --rsh "ssh -i ${SSH_KEY}" \
  --delete-excluded \
  --include-from="${WHITELIST}" \
  --exclude="*" \
  ${SOURCE} \
  ${HOST_USER}@${HOST}:${DESTINATION}
