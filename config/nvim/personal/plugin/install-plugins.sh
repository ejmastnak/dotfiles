#!/bin/bash
# Used to install my Vim plugins to the ~/.config/nvim/pack/ directory
# for use with Vim's built-in package management system
# Create the directory ~/.config/nvim/pack before running the script!

# DEPENDENCY: the Go version of yq ('go-yq' with pacman)

# Usage: install-plugins [plugin-keys]
# EXAMPLE usage: 
# install-plugins.sh  # (applies to all keys in plugins.txt)
# install-plugins.sh vimtex
# install-plugins.sh vimtex asyncrun

# [plugin-key], if provided, should be a valid key name 
# of a dictionary entry in plugins.yml
# EXAMPLE plugins.yml entry:
# vim-commentary:
#   url: "https://github.com/tpope/vim-commentary"
#   dir: "global/"
#   type: "start"

# EXAMPLE yq query:
# yq eval ".vim-commentary.url" plugins.yml

pack_path="$HOME/.config/nvim/pack"

function plug_clone() {
  # clone remote repo into specified directory
  # arg1: url of remote repo
  # arg2: full path to target installation directory
  if git clone "${1}" "${2}"
  then
    echo "Success: cloned ${1} into ${2}"
  else
    echo "ERROR: failed to clone ${1} into ${2}"
  fi
}

# git -C ${git-dir} pull ${remote-url}
function plug_pull() {
  # pull remote repo into existing git directory
  # arg1: url of remote repo
  # arg2: full path to target git directory
  if git -C "${2}" pull "${1}"
  then
    echo "Success: pulled ${1} into ${2}"
  else
    echo "ERROR: failed to pull ${1} into ${2}"
  fi
}

# INSTALL ALL PLUGINS
if [ "$#" == 0 ]
then
  while read key  # read through all lines in include.txt
  do
    [[ -z "$key" ]] && continue    # skip blank lines
    [[ $key = \#* ]] && continue  # skip commented lines
    echo "$key"

    url="$(yq eval ".${key}.url" plugins.yml)"
    parent_dir="$(yq eval ".${key}.parent-dir" plugins.yml)"
    plug_type="$(yq eval ".${key}.type" plugins.yml)"
    name="$(yq eval ".${key}.name" plugins.yml)"
    path="${pack_path}/${parent_dir}/${plug_type}/${name}"

    if [ -d "${path}" ]
    then  # plugin directory exists
      echo "Exists: ${name}. Attempting to update plugin..."
      if [ -d "${path}/.git" ]  # ensure directory contains a git directory
      then
        plug_clone ${url} ${path}
      fi
    else  # plugin directory does not exist
      echo "Absent: ${name}. Installing plugin..."
      mkdir -p "${path}"
      plug_clone ${url} ${path}
    fi
    echo ""
  done < plugins.txt
# --------------------------- #
# INSTALL SPECIFIC PLUGINS ONLY
else
  for key in "$@"
  do

    url="$(yq eval ".${key}.url" plugins.yml)"
    parent_dir="$(yq eval ".${key}.parent-dir" plugins.yml)"
    plug_type="$(yq eval ".${key}.type" plugins.yml)"
    name="$(yq eval ".${key}.name" plugins.yml)"
    path="${pack_path}/${parent_dir}/${plug_type}/${name}"

    # test for invalid keys, in which case the yq query would return the string "null"
    if [ ${url} == "null" ] || [ ${parent_dir} == "null" ] || [ ${plug_type} == "null" ] || [ ${name} == "null" ]
    then
      echo "Invalid key: ${key}"
      continue
    fi

    if [ -d "${path}" ]
    then  # plugin directory exists
      echo "Exists: ${name}. Attempting to update plugin..."
      if [ -d "${path}/.git" ]  # ensure directory contains a git directory
      then
        plug_clone ${url} ${path}
      fi
    else  # plugin directory does not exist
      echo "Absent: ${name}. Installing plugin..."
      mkdir -p "${path}"
      plug_clone ${url} ${path}
    fi
    echo ""
  done
fi
