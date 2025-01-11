#!/usr/bin/env sh

# Default directory
default_dir="${HOME}/.config/wallpapers/"

# Check if an argument is provided
if [ $# -eq 0 ]; then
    # No argument, use default directory
    dir="$default_dir"
else
    # Argument provided, use it as the directory
    dir="$1"
fi

BG="$(find "$dir" -maxdepth 1 -name '*.jpg' -o -name '*.png' | sort -R | head -n 1)"

#trans_type="wipe"
trans_type="fade"
swww img "$BG" --transition-fps 75 --transition-type $trans_type --transition-duration 2.5 --resize crop
