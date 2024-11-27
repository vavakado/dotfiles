#!/usr/bin/env bash

FILENAME=$(date -u +%Y-%m-%dT%H:%M:%S)

grim ~/Pictures/Screenshots/"$FILENAME".png && wl-copy -t image/png < ~/Pictures/Screenshots/"$FILENAME".png
