#!/bin/sh
# SYNOPSIS
#   vimura <synctex_command>
# ARGUMENT
#   <synctex_command> Passed from Vim.
#    The general form is
#    '--synctex-forward line:col:myfile.tex myfile.pdf'
#    E.g. to show line 42, column 11:
#    '--synctex-forward 42:11:myfile.tex myfile.pdf'

# Command implementing inverse search
inverse_command="nvr --servername=/tmp/texsocket +%{line} %{input}"

# Debugging
# echo "zathura -x ${inverse_command} ${@:1}" > $HOME/.config/nvim/personal/log.txt

zathura -x "${inverse_command}" "${@:1}"

# TODO: Don't focus Zathura window when performing forward search.
#       Alternatively, return focus to the parent Vim (Alacritty) process
# On option is to add the following to i3 config:
# no_focus [class="Zathura"]

# TODO: Return focus from Zathura to Vim (Alacritty) on inverse search

# See e.g. https://tex.stackexchange.com/questions/207889/how-to-set-up-forward-inverse-searches-with-auctex-and-zathura
# in the context of emacs
