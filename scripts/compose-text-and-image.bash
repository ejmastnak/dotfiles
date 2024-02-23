#!/bin/bash
# NAME
#     compose-text-and-image.bash - Composes text onto a background image
#
# PARAMETERS
#     $1 text
#     $2 background image
#     $3 output image
#     $4 X dimension (px) of output image
#     $5 Y dimension (px) of output image

ALPHA_HEX="80"  # 00 transparent, FF opaque
COLOR_BG="#000000"
COLOR_TEXT="#FFFFFF"

FONT_FAMILY="LMRoman12-Regular"
FONT_SIZE=32

# Temporary image to store text as a raster image
IMG_TEXT="/tmp/tmp-text-`date +%s`.png"

# Create text image
convert -size ${4}x${5} \
  -background none \
  xc:none \
  -gravity Center \
  -fill "${COLOR_BG}${ALPHA_HEX}" \
  -draw "rectangle 0,0 $(( ${4}-1 )),$(( ${5}-1 ))" \
  -fill ${COLOR_TEXT} \
  -pointsize ${FONT_SIZE} \
  -font ${FONT_FAMILY} \
  caption:"${1}" \
  -composite ${IMG_TEXT}

# Compose text image onto background
composite -gravity SouthEast ${IMG_TEXT} ${2} ${3}

# Clean up
rm -f ${IMG_TEXT}
