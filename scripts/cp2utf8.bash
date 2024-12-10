# NAME
#     cp2utf8 - Convert a CP1250-encoded file to UTF-8
# 
# SYNOPSIS
#     cp2utf8 foo.txt
#
# Used in practice to convert CSV bank statements from Slovene banks to UTF-8

iconv -f CP1250 \
  -t UTF-8 \
  -o "${1}.utf8.tmp" \
  "${1}"

rm "${1}"

mv "${1}.utf8.tmp" "${1}"
