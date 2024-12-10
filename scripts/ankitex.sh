#!/bin/sh
# NAME
# 		ankitex.sh - Open a Vim instance to easily edit Anki LaTeX
# 

file="${HOME}/tmp/scratchpad-`date "+%4Y%m%d%H%M%S"`.ankitex"

printf "[latex]\\n\\n[/latex]" > "${file}"

# Edit the scratchpad file in Vim
alacritty -e nvim -c "let g:anki_scratchpad_file = \"${file}\"" "${file}" -c ":autocmd BufWinLeave * %y<CR>" &
alacritty_pid="$!"

# Give Alacritty time to open
sleep 0.5s

alacritty_winID=`xdotool search --pid ${alacritty_pid}`

i3-msg "[id=${alacritty_winID}] floating enable"
