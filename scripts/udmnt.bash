#!/bin/bash
# NAME
#     udmnt.bash - Mount block device using udisksctl
# SYNOPSIS
#     udmnt.bash [path/to/device/partition]
# DESCRIPTION
# Mounts the partition of a block device (in practice the data partition of
# removable USB storage drives). When no parameters are passed, assumes the
# partition to mount is /dev/sdb1.
#
# DEPENDENCIES: udisksctl

if [[ "$#" -ge 2 ]]; then
  echo "Usage: udmnt.bash [path/to/device/partition]"
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

udisksctl mount --block-device "${partition}"
