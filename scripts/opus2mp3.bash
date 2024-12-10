#!/bin/bash
# NAME
#     opus2mp3.bash - Convert OPUS files in current directory to MP3
# 
# SYNOPSIS
#     opus2mp3.bash


for opus in *.opus; do
  basename=${opus%.opus}
  echo "${basename}"
  ffmpeg -i "${opus}" -ac 2 "${basename}.mp3"
done;
