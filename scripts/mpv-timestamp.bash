#!/usr/bin/env bash
# Used to open a given media file at a specified timestamp.
#
# Example input: "path/to/foo/bar.mp3;00:31:12"

# # Get the string from the clipboard
# file_timestamp=$(xclip -o -selection clipboard)

input="${1}"
file="${input%%;*}"
timestamp="${input##*;}"

mpv --start="${timestamp}" "${file}"
