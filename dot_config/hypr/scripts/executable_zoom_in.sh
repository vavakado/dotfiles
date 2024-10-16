#!/usr/bin/env bash

compare_floats() {
    awk -v n1="$1" -v n2="$2" 'BEGIN {if (n1<n2) exit 0; exit 1}'
}

ZOOM_FACTOR=$(hyprctl getoption cursor:zoom_factor -j | jq .float)

NEW_ZOOM_FACTOR=$(echo "scale=4; $ZOOM_FACTOR + 0.20" | bc -l)

if compare_floats $NEW_ZOOM_FACTOR 5.0; then
	hyprctl keyword cursor:zoom_factor $NEW_ZOOM_FACTOR 
fi
