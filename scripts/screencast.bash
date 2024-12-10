#!/bin/bash
# NAME
#     screencast - Record area of screen selected by mouse, with audio.
#
# Uses ffmpeg with x11grab to record the area of the screen selected by the
# mouse, with audio.
# References: 
# - https://wiki.archlinux.org/title/FFmpeg#Screen_capture
# - https://www.ffmpeg.org/ffmpeg-devices.html#Options-20

# Use timestamp to ensure unique filename
output="${HOME}/Videos/rec-$(date +%Y-%m-%d-%S-%N).mp4"

if pgrep -x "ffmpeg" > /dev/null
then
  pkill ffmpeg
else
  slop=$(slop -f "%x %y %w %h %g %i") || exit 1
  read -r X Y W H G ID <<< ${slop}
  ffmpeg -f x11grab -video_size ${W}x${H} -grab_x ${X} -grab_y ${Y} -framerate 25 -i ${DISPLAY} -f alsa -i default -c:v libx264 -preset ultrafast -c:a aac ${output}
fi

