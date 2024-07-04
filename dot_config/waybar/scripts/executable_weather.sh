#!/bin/sh
LOC="32.81841,34.9885"

text="$(curl -s "https://wttr.in/$LOC?format=1" | sed 's/ //g')"
tooltip="$(curl -s "https://wttr.in/$LOC?0QT" |
    sed 's/\\/\\\\/g' |
    sed ':a;N;$!ba;s/\n/\\n/g' |
    sed 's/"/\\"/g')"

if ! grep -q "Unknown location" <<< "$text"; then
    echo "{\"text\": \"$text\", \"tooltip\": \"<tt>$tooltip</tt>\", \"class\": \"weather\"}"
fi

