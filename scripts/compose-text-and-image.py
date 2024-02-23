#!/usr/bin/env python
"""
compose-text-and-image.bash - Composes text onto a background image

For documentation see help entries for argparse parameters below, or run
`compose-text-and-image.py --help` from the command line.

Dependency: ImageMagick
"""

import sys, pathlib, subprocess, argparse, time

# Program name
parser = argparse.ArgumentParser(
                    prog='compose-text-and-image',
                    description='Compose text onto a background image.')

# Required arguments
parser.add_argument('text',
                    help="The text to compose on the background image.")
parser.add_argument('bg_img',
                    help="Path to the background image onto which to compose text.")
parser.add_argument('output_img',
                    help="Path at which to save the composite image.")

# Optional arguments
parser.add_argument('--text-x-px',
                    default=None,
                    type=int,
                    help="X dimension, in pixels, of text panel.")
parser.add_argument('--text-y-px',
                    default=None,
                    type=int,
                    help="Y dimension, in pixels, of text panel.")
parser.add_argument('--bg-color',
                    default="#000000",
                    help="Hex color string for text panel's background color.")
parser.add_argument('--bg-alpha',
                    default="80",
                    help="Hex alpha value for text panel's background, from 00 (transparent) to FF (opaque).")
parser.add_argument('--text-color',
                    default="#FFFFFF",
                    help="Hex color string for text color.")
parser.add_argument('--font-family',
                    default="LMRoman12-Regular",
                    help="Name of font family to use for text.")
parser.add_argument('--font-size',
                    default="32",
                    help="Font size, in points, to use for text.")
parser.add_argument('--text-gravity',
                    default="SouthEast",
                    help="ImageMagick gravity keyword controlling where to place text panel in composite image.")

args = parser.parse_args()

x_text = args.text_x_px
if x_text == None:
    # X dimension, in pixels, of background image
    x_bg = int(subprocess.run(['identify', '-format', '%w', args.bg_img], stdout=subprocess.PIPE).stdout.decode('utf-8'))
    x_text_target = 635  # from (1920 px)/3 - 5 px gap (half of 10px gap)
    x_text = int(x_text_target * x_bg / 1920)  # scaling relative to bg width

y_text = args.text_y_px
if y_text == None:
    y_text = int(subprocess.run(['identify', '-format', '%h', args.bg_img], stdout=subprocess.PIPE).stdout.decode('utf-8'))

# Temporary image to store text as a raster image
tmp_txt_img="/tmp/tmp-text-img-" + str(int(time.time()*1000)) + ".png"

# Create text image
result = subprocess.run([
    "convert",
    "-size", "{}x{}".format(x_text, y_text),
    "xc:none",
    "-background", "none",
    "-gravity", "Center",
    "-fill", "{}{}".format(args.bg_color, args.bg_alpha),
    "-draw", "rectangle 0,0 {},{}".format(x_text-1, y_text-1),
    "-fill", args.text_color,
    "-pointsize", args.font_size,
    "-font", args.font_family,
    "caption:{}".format(args.text),
    "-composite", tmp_txt_img
    ])

# Compose temporary text image onto background
subprocess.run([
    "composite",
    "-gravity", args.text_gravity,
    tmp_txt_img,
    args.bg_img,
    args.output_img
    ])

# Clean up
path = pathlib.Path(tmp_txt_img)
path.unlink()
