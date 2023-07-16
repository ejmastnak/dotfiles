#!/bin/bash
# NAME
#     sloppycopy.bash - Copy slop output to X Clipboard
# 
# SYNOPSIS
#     sloppycopy.bash
#
# DESCRIPTION
#     Literally just a one-liner to copy slop's output to cliboard
slop | xclip -selection clipboard
