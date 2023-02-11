#!/bin/bash
# NAME
# 		backup-home.bash - Back up home directory to external disk using rsync
# 
# SYNOPSIS
# 		backup-home.bash

home="/home/ej"
backup="/run/media/ej/Seagate/backups/ej"

rsync_config_dir="${home}/.config/rsync/"
include_list="home-backup-include.conf"
exclude_list="home-backup-exclude.conf"

# Iterate through all directories `dir_to_backup` in `include_list`.
while read dir_to_backup
do
  [[ -z "${dir_to_backup}" ]] && continue     # skip blank lines
  [[ "${dir_to_backup}" = \#* ]] && continue  # skip commented lines
  echo "Backing up ${dir_to_backup}"

  # Options:
  # --recursive recurse into subdirectories
  # --perms preserve permissions
  # --times preserve modification times
  rsync \
    --recursive \
    --perms \
    --times \
    --exclude-from="${home}/.config/rsync/${exclude_list}" \
    "${home}/${dir_to_backup}" "${backup}"

done < "${rsync_config_dir}/${include_list}"

date > "${backup}/BACKUP_DATE"
