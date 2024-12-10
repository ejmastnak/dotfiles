# NAME
#     inkscape-keys-toggle.bash - Toggle custom Inkscape key mappings
# 
# SYNOPSIS
#     inkscape-keys-toggle.bash
# DESCRIPTION
#     This script is part of a custom key interception layer around Inkscape;
#     it "turns on" and "turns off" these custom keys by creating/deleting a
#     special indicator file `/tmp/inkscape_keys`.

if [[ "$#" -gt 1 ]]; then
  echo "Usage: inkscape-keys-toggle.bash"
  exit 1
fi

INKSCAPE_KEYS="/tmp/inkscape_keys"
I3_BLOCKS_UPDATE_SIGNAL=1

if [[ -e ${INKSCAPE_KEYS} ]]; then
  rm ${INKSCAPE_KEYS}
else
  touch ${INKSCAPE_KEYS}
fi

# Refresh i3 status bar
pkill -SIGRTMIN+${I3_BLOCKS_UPDATE_SIGNAL} i3blocks
