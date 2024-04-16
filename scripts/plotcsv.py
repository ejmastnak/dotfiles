#!/usr/bin/env python
"""
NAME
    plotcsv.py - Plot a CSV file with Matplotlib
SYNOPSIS
    plotcsv.py file.csv
DESCRIPTION
    For when I'm poking around some unfamiliar data and a need a quick one-line
    command to plot a CSV file.
"""
import argparse
import numpy as np
import matplotlib.pyplot as plt

# Program name
parser = argparse.ArgumentParser(prog='plotcsv.py', description='Plots a CSV file with Matplotlib.')

# Required arguments
parser.add_argument('csv', help="The CSV file to plot")

# Optional arguments
parser.add_argument('-i', '--index',
                    action='store_true',
                    help="When present, the first column is treated as an independent variable")
parser.add_argument('-s', '--skip-rows',
                    default=0,
                    type=int,
                    help="How many rows of the CSV file to skip (default: 0)")
parser.add_argument('-d', '--delimiter',
                    default=',',
                    help="Delimiter passed to numpy.loadtxt (default: ',')")
parser.add_argument('-c', '--comments',
                    default='#',
                    help="Comment string passed to numpy.loadtxt (default: '#')")
parser.add_argument('-m', '--marker',
                    default='.',
                    help="Marker string passed to pyplot.plot (default: '.')")

# Parse args
args = parser.parse_args()

data = np.loadtxt(args.csv, 
                  comments=args.comments,
                  delimiter=args.delimiter,
                  skiprows=args.skip_rows)

if args.index:
    for i in range(1, data.shape[1]):
        plt.plot(data[:, 0], data[:, i], label=str(i), marker=args.marker)
else: 
    for i in range(data.shape[1]):
        plt.plot(data[:, i], label=str(i), marker=args.marker)

plt.legend()
plt.show()
