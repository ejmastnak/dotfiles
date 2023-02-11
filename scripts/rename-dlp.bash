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

if [[ ${#} -ne 2 ]]
then
  echo "Usage: rename-dlp.bash ./ ext"
  exit
fi

cd "${1}"

# Remove YouTube ID
perl-rename 's/ \[.*\]//' *.${2}

# # Replace spaces with hyphens
perl-rename 's/\s+/-/g' *.${2}
#
# # Change to lowercase
perl-rename 'y/A-Z/a-z/' *.${2}
