#!/usr/bin/env python
"""
NAME
    i3-move-container-lr.py - Move an i3 container left/right between workspaces
SYNOPSIS
    i3-move-container-lr.py [left|right]
DESCRIPTION
    Moves the currently focused i3 container to the numerically-adjacent left
    or right i3 workspace, creating the workspace if necessary.
"""
import sys, pathlib, subprocess, json, argparse

N = 10
MOVE_RIGHT = 0
MOVE_LEFT = 1

def main(direction):
    result = subprocess.run(["i3-msg", "-t", "get_workspaces" ], stdout=subprocess.PIPE).stdout.decode('utf-8')
    workspaces = json.loads(result)

    focused_idx = None
    for idx, ws in enumerate(workspaces):
        if ws['focused']:
            focused_idx = idx
            break

    if focused_idx is None:
        print("Error: could not find focused workspace. Aborting", file=sys.stderr)
        sys.exit(1)

    focused_num = workspaces[focused_idx]['num']
    dest_num = (focused_num + 1)%10 if direction == MOVE_RIGHT else (focused_num - 2)%10 + 1
    subprocess.run(["i3-msg", "move container to workspace number {}".format(dest_num)])
    subprocess.run(["i3-msg", "workspace number {}".format(dest_num)])


if __name__ == "__main__":
    parser = argparse.ArgumentParser(prog='i3-move-container-lr.py', description='Move an i3 container left/right between workspaces')
    parser.add_argument('direction', help="left|right", choices=['left', 'right', 'l', 'r'])
    args = parser.parse_args()
    main(MOVE_RIGHT if args.direction.startswith('r') else MOVE_LEFT)
