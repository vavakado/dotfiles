#!/usr/bin/env sh
HYPRGAMEMODE=$(hyprctl getoption decoration:blur:enabled | awk 'NR==1{print $2}')
if [ "$HYPRGAMEMODE" = 1 ] ; then
    hyprctl --batch "\
        keyword decoration:blur:enabled 0;\
		keyword decoration:inactive_opacity 1.0"
    exit
fi
hyprctl reload
