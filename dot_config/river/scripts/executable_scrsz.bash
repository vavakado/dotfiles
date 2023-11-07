#!/usr/bin/env bash

# Set variables for image format, quality, destination folder, etc.
SCREENSHOT_DIR=~/Screenshots
DAY=$(date +'%d')
MONTH=$(date +'%m')
YEAR=$(date +'%Y')
time=$(date +%H.%M)
SAVE_TO_DIR=$SCREENSHOT_DIR/$YEAR.$MONTH
NAME=&

# Create the destination directory if it doesn't exist
mkdir -p "$SAVE_TO_DIR"

# Use scrot to capture the screen
slurp | grim -g - "$SAVE_TO_DIR/$time.png" && cat "$SAVE_TO_DIR/$time.png" | wl-copy
magick "$SAVE_TO_DIR/$time.png" "$SAVE_TO_DIR/$time.webp"
rm "$SAVE_TO_DIR/$time.png"
