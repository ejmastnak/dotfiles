# NAME
#     inkscape.bash - Start Inkscape with support for custom key interception
# 
# SYNOPSIS
#     inkscape.bash [file]
# DESCRIPTION
#     This script is part of a custom key interception layer around Inkscape.
# CAVEATS
#     The interception layer only works with one Inkscape instance running at a
#     given time

if [[ "$#" -gt 1 ]]; then
  echo "Usage: inkscape.bash [file]"
  exit 1
fi

INKSCAPE_KEYS="/tmp/inkscape_keys"
I3_BLOCKS_UPDATE_SIGNAL=1

# Redirect noisy stdout/stderr to /dev/null
if [[ "$#" -eq 0 ]]; then
  inkscape > /dev/null 2>&1 &
elif [[ "$#" -eq 1 ]]; then
  inkscape "${1}" > /dev/null 2>&1 &
fi
inkscape_pid=$!
touch ${INKSCAPE_KEYS}

# Refresh i3 status bar
pkill -SIGRTMIN+${I3_BLOCKS_UPDATE_SIGNAL} i3blocks

wait ${inkscape_pid}
rm -f ${INKSCAPE_KEYS}
# Refresh i3 status bar
pkill -SIGRTMIN+${I3_BLOCKS_UPDATE_SIGNAL} i3blocks
