#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/.config/wallpapers/day-night/"

set_wallpaper() {
	swww img "$1" --transition-fps 75 --transition-type fade --transition-duration 2.5 --resize crop
}


while true; do
    HOUR=$(date +%H)

    if [ $HOUR -ge 22 ] || [ $HOUR -lt 5 ]; then
        # Night: 22:00 - 04:59
        set_wallpaper "$WALLPAPER_DIR/desert-sands-00.png"
    elif [ $HOUR -ge 5 ] && [ $HOUR -lt 10 ]; then
        # Sunrise: 05:00 - 09:59
        set_wallpaper "$WALLPAPER_DIR/desert-sands-01.png"
    elif [ $HOUR -ge 10 ] && [ $HOUR -lt 16 ]; then
        # Midday: 10:00 - 15:59
        set_wallpaper "$WALLPAPER_DIR/desert-sands-02.png"
    elif [ $HOUR -ge 16 ] && [ $HOUR -lt 19 ]; then
        # Sunset: 16:00 - 18:59
        set_wallpaper "$WALLPAPER_DIR/desert-sands-03.png"
    else
        # After sunset: 19:00 - 21:59
        set_wallpaper "$WALLPAPER_DIR/desert-sands-04.png"
    fi
    
    sleep 300  # Check every 5 minutes
done
