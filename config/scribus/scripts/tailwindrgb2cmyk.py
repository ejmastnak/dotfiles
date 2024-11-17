#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
ABOUT THIS SCRIPT:

Replaces all colors with names of the form "FromSVG#f8fafc" with the corresponding Tailwind CSS color, e.g. "slate50_cmyk".

Uses `getColorNames` to access the document's colors and `replaceColor` to
"oldcolorname" with "newcolorname".

There must be a document opened in Scribus in which both the old and new colors
are defined.

############################

LICENSE:

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.

Author: Sebastian Stetter

please report bugs to: scribusscript@sebastianstetter.de
"""
from __future__ import division
import sys

__version__=1.1

HEX2NAME = "/home/ej/Documents/design/colors/tailwind-reversed.yaml"

try:
    # Please do not use 'from scribus import *' . If you must use a 'from import',
    # Do so _after_ the 'import scribus' and only import the names you need, such
    # as commonly used constants.
    import scribus
except ImportError as err:
    print ("This Python script is written for the Scribus scripting interface.")
    print ("It can only be run from within Scribus.")
    sys.exit(1)

#########################
# YOUR IMPORTS GO HERE  #
#########################
import csv
import os
import yaml

PREFIX="FromSVG"
PREFIX_LEN=len(PREFIX)

def replaceColors():
        """check if colors exists an import"""
        scribus.statusMessage("Replacing new colors...")

        # Maps Tailwind color hex codes to names, e.g. `'#f8fafc': slate50`
        hex2name_dict = {}
        with open(HEX2NAME, 'r') as file:
            hex2name_dict = yaml.safe_load(file)

        colorlist = scribus.getColorNames()
        scribus.progressTotal(len(colorlist))

        failedReplacements = []

        i=0
        for rgbcolor in colorlist:
            # Extracts e.g. "#f8fafc" from "FromSVG#f8fafc"
            if rgbcolor.startswith(PREFIX) and rgbcolor[PREFIX_LEN:] in hex2name_dict:
                cmykcolor = hex2name_dict.get(rgbcolor[PREFIX_LEN:]) + "_cmyk"
                try:
                    scribus.replaceColor(rgbcolor, cmykcolor)
                except:
                    failedReplacements.append(f"{rgbcolor} -> {cmykcolor}")
            i=i+1
            scribus.progressSet(i)
        return failedReplacements

def main(argv):
    """Main method for importing colors."""

    if not os.path.isfile(HEX2NAME):
        scribus.messageBox("csv2color", f"Could not find Tailwind CSS hex code to name mapping at {HEX2NAME}. Exiting.")
        sys.exit()

    if not scribus.haveDoc() > 0: #do we have a doc?
        scribus.messageBox("csv2color", "No document to import colors \n Please open one, first.")
        sys.exit()

    try:
        failedReplacements = replaceColors()
        scribus.docChanged(True)
        message = "Done!"
        if len(failedReplacements) > 0:
            message += f" (with {len(failedReplacements)} errors)"
            message += "\nFailed to replace the following colors:\n{}".format("\n".join(failedReplacements))
        scribus.messageBox("csv2color", message)
    except Exception as e:
        scribus.messageBox("csv2color", "{e}".format(), icon=scribus.ICON_WARNING)
        sys.exit()
            


def main_wrapper(argv):
    """The main_wrapper() function disables redrawing, sets a sensible generic
    status bar message, and optionally sets up the progress bar. It then runs
    the main() function. Once everything finishes it cleans up after the main()
    function, making sure everything is sane before the script terminates."""
    try:
        #scribus.statusMessage("Running script...")
        scribus.progressReset()
        main(argv)
    finally:
        # Exit neatly even if the script terminated with an exception,
        # so we leave the progress bar and status bar blank and make sure
        # drawing is enabled.
        if scribus.haveDoc():
            scribus.setRedraw(True)
        scribus.statusMessage("")
        scribus.progressReset()

# This code detects if the script is being run as a script, or imported as a module.
# It only runs main() if being run as a script. This permits you to import your script
# and control it manually for debugging.
if __name__ == '__main__':
    main_wrapper(sys.argv)
