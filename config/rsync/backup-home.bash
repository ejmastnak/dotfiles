#!/bin/bash
# NAME
# 		backup-home.bash - Back up home directory to external disk using rsync
# 
# SYNOPSIS
# 		backup-home.bash

home="/home/ej"
rsync_config_dir="${home}/.config/rsync/"
include_list="home-backup-include.conf"
exclude_list="home-backup-exclude.conf"

# Back up all subdirectories of the home directory that appear in $include_list
while read dir_to_backup
do
  [[ -z "${dir_to_backup}" ]] && continue     # skip blank lines
  [[ "${dir_to_backup}" = \#* ]] && continue  # skip commented lines
  echo "${dir_to_backup}"

  rsync -rptD --exclude-from="${home}/.config/rsync/${exclude_list}" "${home}/${dir_to_backup}" /mnt/seagate/backups/ej

done < "${rsync_config_dir}/${include_list}"
