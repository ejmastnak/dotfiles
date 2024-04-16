#!/bin/bash
# Used in conjuction with reset-keyboard-after-wake.service
sleep 1
xset r rate 200 40
xmodmap ${HOME}/.xmodmaprc
