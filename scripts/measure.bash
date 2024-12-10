#!/usr/bin/env bash
# Measures the dimensions (e.g. "400x300") in pixels of a selection of the
# screen.
# Uses slop for selection. Both copies result to clipboard and displays
# dimensions using notify-send.

EXPIRE_TIME_MS=5000

slop=$(slop -f "%x %y %w %h %g %i") || exit 1
read -r X Y W H G ID <<< ${slop}
printf "${W} x ${H}" | xclip -selection clipboard
notify-send --expire-time=${EXPIRE_TIME_MS} --transient "${W} x ${H}"
