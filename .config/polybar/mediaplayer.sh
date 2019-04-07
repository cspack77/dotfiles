#!/bin/bash

if [[ ! -z $(pidof mpd) ]]
then
    mpdstatus=$(mpc -f "[[%artist% - ]%title%]")
    lines=$(echo "$mpdstatus" | wc -l)
    if [[ $lines -eq 3 ]]; then
        playpause=$(echo "$mpdstatus" | grep -o "playing\|paused" | sed -e 's/paused//' -e 's/playing//')
        track=$(echo "$mpdstatus" | head -1)
        volume=$(echo "$mpdstatus" | grep -Po 'volume:\s?\K[0-9\%]+')
        volumeicon=""
        text="$playpause $track   $volumeicon $volume"
    fi
fi

echo "$text"
