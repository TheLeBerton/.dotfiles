#!/bin/bash

volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2}')
volume_percent=$(echo "$volume*100/1" | bc)
is_muted=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep MUTED | awk '{print $3}')

if [ "$is_muted" = "[MUTED]" ]; then
    msg="Muted"
    notify-send -h string:x-dunst-stack-tag:volume \
                -t 750 \
                "Volume" "$msg"
else
    msg="${volume_percent}%"
    notify-send -h int:value:"$volume_percent" \
                -h string:x-dunst-stack-tag:volume \
                -t 750 \
                "Volume" "$msg"
fi
