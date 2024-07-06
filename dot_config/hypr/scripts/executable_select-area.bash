#!/usr/bin/env bash

FILENAME=$(date -u +%Y-%m-%dT%H:%M:%S)

flameshot gui -p ~/Screenshots/"$FILENAME".png && wl-copy -t image/png < ~/Screenshots/"$FILENAME".png
