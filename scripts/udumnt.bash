#!/bin/bash
# NAME
#     udumnt.bash - Unmount block device using udisksctl
# SYNOPSIS
#     udumnt.bash [path/to/device/partition]
# DESCRIPTION
# Unmounts and powers off the partition of a block device (in practice the data
# partition of removable USB storage drives). When no parameters are passed,
# assumes the partition to unmount is /dev/sdb1.
#
# DEPENDENCIES: udisksctl

if [[ "$#" -ge 2 ]]; then
  echo "Usage: udumnt.bash [path/to/device/partition]"
  exit 1
fi

if [[ "$#" -eq 0 ]]; then
  partition="/dev/sdb1"
elif [[ "$#" -eq 1 ]]; then
  partition="${1}"
fi

if [[ $partition =~ "sda" ]]; then
  echo "Warning: partition name (${partition}) contains sda; aborting out of caution. Use udisksctl manually to override."
fi

udisksctl unmount --block-device "${partition}" && udisksctl power-off --block-device "${partition}"
