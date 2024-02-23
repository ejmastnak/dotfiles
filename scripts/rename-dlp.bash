# NAME
#     rename-dlp.bash - Rename media files after download with yt-dlp
# 
# SYNOPSIS
#     rename-dlp.bash dir ext
#     E.g. rename-dlp.bash ./ opus
# 
# EXAMPLES INPUT/OUTPUT:
#     Input: Foo Bar [SDfj323jsls].mp4
#     Output: foo-bar.mp4

if [[ ${#} -eq 0 ]]; then
  DIR="./"
  EXT="opus"
elif [[ ${#} -eq 2 ]]; then
  DIR="${1}"
  EXT="${2}"
else
  echo "Usage: rename-dlp.bash directory extension"
  exit
fi

cd "${DIR}"

# Remove YouTube ID
perl-rename 's/ \[.*\]//' *.${EXT}

# # Replace spaces with hyphens
perl-rename 's/\s+/-/g' *.${EXT}
#
# # Change to lowercase
perl-rename 'y/A-Z/a-z/' *.${EXT}
