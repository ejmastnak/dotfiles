#!/bin/sh
# Example before: "My Favorite Things"
# Example after: "my-favorite-things"
# Remaining song information should be moved to ID3 tags

# Usage: music-rename.sh <directory>
# Arguments:
# $1 <directory> is full path to a directory containing *.mp3 files

# Change to directory with music files
cd "${1}"

# Replace spaces with dashes
perl-rename 's/ /-/g' *

# Make the names of all `mp3` files lowercase 
perl-rename 'y/A-Z/a-z/' *
