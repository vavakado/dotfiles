#!/usr/bin/env bash

FILENAME=$(date -u +%Y-%m-%dT%H:%M:%S)

grim ~/Screenshots/"$FILENAME".png && wl-copy -t image/png < ~/Screenshots/"$FILENAME".png
