#!/bin/bash

WALLDIR="$HOME/wallpapers"

# pick random wallpaper
WALL=$(find "$WALLDIR" -type f | shuf -n 1)

# apply wallpaper (swaybg)
pkill swaybg
swaybg -i "$WALL" -m fill &

# generate pywal colors
wal -i "$WALL"
