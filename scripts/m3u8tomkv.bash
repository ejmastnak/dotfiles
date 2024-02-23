# NAME
#     m3u8tomkv.bash - Convert a M3U8 file to MKV
# 
# SYNOPSIS
#     m3u8tomkv.bash stream.m3u8
#
# A simple wrapper around ffmpeg to convert a stream of MPEG chunks to a single
# MKV file on disk.
# Thank you to:
# - https://stackoverflow.com/questions/32528595/ffmpeg-mp4-from-http-live-streaming-m3u8-file 
# - https://stackoverflow.com/questions/50455695/why-does-ffmpeg-ignore-protocol-whitelist-flag-when-converting-https-m3u8-stream

ffmpeg -protocol_whitelist file,http,https,tcp,tls,crypto -i "${1}" -c copy "${1%%.*}.mkv"
