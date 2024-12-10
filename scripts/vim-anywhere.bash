#!/bin/bash
# NAME
# 		vim-anywhere.vim - Open a floating Vim instance and save buffer contents
# 		to clipboard on exit.
# 

file="${HOME}/tmp/scratchpad-`date "+%4Y%m%d%H%M%S"`.md"

# Edit the scratchpad file in Vim; save buffer contents to clipboard on exit
alacritty -e nvim  \
  -c ":autocmd BufWinLeave * %y<CR>" \
  -c ":noremap ZZ <Cmd>wq<CR>" \
  -c ":noremap <Space>q <Cmd>wq<CR>" \
  "${file}" \
  &
alacritty_pid="$!"

# Give Alacritty time to open
sleep 0.5s

alacritty_winID=`xdotool search --pid ${alacritty_pid}`

i3-msg "[id=${alacritty_winID}] floating enable"

# Remove scratchpad file after closing terminal
wait ${alacritty_pid}
rm -f ${file}
