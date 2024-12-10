#!/bin/sh
# Goal: rename music file names from my pre-Unix naming convention days
# Remaining song information should be moved to ID3 tags.
#
# EXAMPLES
#   Before: "1 My Favorite Things - John Coltrane.mp3"
#   After: "my-favorite-things.mp3"

# Note to self: useful for removing yt-dlp tags:
# perl-rename -n 's/ \[.*\]//' *.opus

# Usage: music-rename.sh <directory>
# Arguments:
# $1 <directory> is full path to a directory containing *.mp3 files

# Change to directory with music files
cd "${1}"

# Will store old names in a text file for reference
echo "Old Names:" > old-names.txt

function rename_and_tag() {
  echo "${filename}" >> old-names.txt

  # Remove prepending number and the space immediately following it
  # Then remove artist name and prepending dash, leaving the song name
  newname=`echo "${1}" | \
    sed 's/^[0-9]* *//' | \
    sed 's/ - .*\.\([mp3opus]\+\)$/.\1/'`

  # Tag song with song name
  title=${newname%%.*}
  id3tag --song="${title}" "${filename}"

  # Replace spaces with dashes
  # Then make the names of all `mp3` files lowercase 
  newname=`echo "${newname}" | \
    sed 's/ /-/g' | \
    tr '[:upper:]' '[:lower:]'`

  mv "${filename}" "${newname}"
}

shopt -s nullglob
for filename in *.{mp3,opus}
do
  rename_and_tag "${filename}"
done
shopt -u nullglob
