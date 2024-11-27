#!/usr/bin/env bash
state="$(hyprctl -j clients)"
active_window="$(hyprctl -j activewindow)"
current_addr="$(echo "$active_window" | jq -r '.address')"

window_list="$(echo "$state" | jq -r '.[] | select(.monitor != -1) | "\(.address) \(.initialTitle)"' | sed "s|$current_addr|focused ->|" | sort)"

selected_window="$(echo "$window_list" | wofi --dmenu --fuzzy)"

if [ -n "$selected_window" ]; then
    addr="$(echo "$selected_window" | awk '{print $1}')"
    hyprctl dispatch focuswindow address:"$addr"
fi
