#!/bin/bash
# Syncs music and audio to Raspberry Pi

SOURCE="${HOME}/Music/library/"
SSH_KEY="${HOME}/.ssh/Pi_id_ed25519"
WHITELIST="${SOURCE}/whitelist-rsync.conf"
HOST="pi3bp.local"
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
