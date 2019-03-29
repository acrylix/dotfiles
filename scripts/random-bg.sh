#!/bin/sh

WALL=$(find "${HOME}/Pictures/wal/cyberpunk/" -type f | sort -R | tail -1)
feh --no-fehbg --bg-fill "$WALL"