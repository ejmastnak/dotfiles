#!/bin/bash
# NAME
#     ssh-with-agent.bash - Dynamically add keys to ssh-agent, then ssh
# 
# SYNOPSIS
#     ssh-with-agent.bash host
# 
# Used to dynamically add keys to ssh-agent on the key's first use in the
# current ssh-agent session.

if [[ "$#" -ne 1 ]]; then
  echo "Usage: ssh-with-agent.bash host"
  exit 1
fi

add_keys_to_agent=1

if [[ -z "${SSH_AUTH_SOCK}" ]]; then
  echo "Error: ssh-agent is not running. Not adding keys."
  add_keys_to_agent=0
fi

# Extract identity file for a given host from SSH config; the `awk` call relies
# on the format `identityfile ~/.ssh/DigitalOceanDefault_id_ed25519`
get_identity_file() {
  local host=${1}
  ssh -G ${host} | awk '$1 == "identityfile" { print $2; exit }'
}

# Extract public key blob from an SSH public key file
get_public_key_blob() {
  local pubkey_file=${1}
  head -1 "${pubkey_file}" | awk '{print $2}'
}

if [[ ${add_keys_to_agent} -gt 0 ]]; then
  # Original SSH command host
  SSH_HOST=${1}
  SSH_ADD_TIMEOUT=36000  # seconds

  # Get the identity file for the host (and replace ~ with actual value of
  # ${HOME} to avoid problems with ~ not expanding in quotes down the line).
  IDENTITY_FILE=$(get_identity_file ${SSH_HOST})
  IDENTITY_FILE="${IDENTITY_FILE//\~/$HOME}"
  PUBKEY_FILE="${IDENTITY_FILE}.pub"
  PUBKEY_BLOB=$(get_public_key_blob "${PUBKEY_FILE}")

  # Check if this specific key is loaded in ssh-agent
  if [[ -n "${IDENTITY_FILE}" ]] && ! ssh-add -L | grep -Fq "${PUBKEY_BLOB}"; then
    echo "Key ${IDENTITY_FILE} for Host ${SSH_HOST} not loaded."
    read -p "Add key to ssh-agent? [Y/n]" response
    if [[ "${response}" == "n" ]]; then
      echo "Not adding key to ssh-agent."
    else
      echo "Adding key to ssh-agent..."
      ssh-add -t ${SSH_ADD_TIMEOUT} ${IDENTITY_FILE}
    fi
  fi

fi

# Proceed with the original SSH command
echo "Connecting to Host ${SSH_HOST} with SSH..."
/usr/bin/ssh "${@}"
