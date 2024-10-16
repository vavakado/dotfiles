#!/bin/sh

# Check if wofi is already running
if ! pgrep -x ".wofi-wrapped"; then
    # If not running, open wofi
    wofi &
else
    echo "wofi is already running."
fi
