#!/bin/bash

get_active_sink() {
    local active_sync=$(pacmd list-sinks |grep "* index" |awk '{print $3}')
    echo $active_sync
}

trim_to_range() {
    local volume=$1
    if [ $volume -lt 0 ]; then
        volume=0
    elif [ $volume -gt 150 ]; then
        volume=150
    fi
    echo $volume
}

set_volume() {
    pactl set-sink-volume $(get_active_sink) "${1}%"
}

volume_up() {
    local curr_volume=$(get_volume | cut -d '%' -f 1)
    local new_volume=$(($curr_volume+$1))
    new_volume=$(trim_to_range $new_volume)
    set_volume $new_volume
}

volume_down() {
    local curr_volume=$(get_volume | cut -d '%' -f 1)
    local new_volume=$(($curr_volume-$1))
    local new_volume=$(trim_to_range $new_volume)
    set_volume $new_volume
}

get_volume() {
    local volume=$(amixer -D pulse get Master | grep -o "\[.*%\]" | grep -o "[0-9\%]*" | head -n1)
    echo "$volume"
}

is_muted() {
    local status=$(amixer -D pulse get Master | grep -o "\[on\]" | head -n1)
    [[ "$status" == "[on]" ]] && return 1 || return 0
}

toggle_volume() {
    amixer -D pulse set Master Playback Switch toggle
}

output_message() {
    local volume=$(get_volume)
    local icon=""
    local color="%{F-}"
    if is_muted; then
        icon=""
        color="%{F#755a5b}"
    fi 
    echo "${color}${icon} ${volume}%{F-}"
}

case "$1" in
    up)
        volume_up "$2"
        ;;
    down)
        volume_down "$2"
        ;;
    toggle)
        toggle_volume
        ;;
    *)
        ;;
esac

output_message
