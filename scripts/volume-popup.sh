#!/bin/bash

# Volume notification for Asahi Linux
# Uses multiple sources to get volume info

# Function to get volume percentage
get_volume_info() {
    # Try amixer first (most reliable on Asahi)
    amixer_info=$(amixer get Master 2>/dev/null)
    if [ $? -eq 0 ]; then
        volume_percent=$(echo "$amixer_info" | grep -oP '\[\d+%\]' | head -1 | sed 's/\[//;s/%\]//')
        is_muted=$(echo "$amixer_info" | grep -o '\[off\]')

        if [ -n "$is_muted" ]; then
            echo "MUTED:0"
        else
            echo "UNMUTED:$volume_percent"
        fi
        return
    fi

    # Fallback to wpctl
    wpctl_info=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null)
    if [ $? -eq 0 ]; then
        volume_decimal=$(echo "$wpctl_info" | awk '{print $2}')
        is_muted=$(echo "$wpctl_info" | grep -o 'MUTED')

        if [ -n "$is_muted" ]; then
            echo "MUTED:0"
        elif [ -n "$volume_decimal" ]; then
            volume_percent=$(awk "BEGIN {printf \"%.0f\", $volume_decimal * 100}")
            echo "UNMUTED:$volume_percent"
        else
            echo "UNMUTED:100"
        fi
        return
    fi

    # Final fallback
    echo "UNMUTED:100"
}

# Get volume info
vol_info=$(get_volume_info)
status=$(echo "$vol_info" | cut -d: -f1)
volume_percent=$(echo "$vol_info" | cut -d: -f2)

if [ "$status" = "MUTED" ]; then
    msg="󰝟 Muted"
    notify-send -h string:x-dunst-stack-tag:volume \
                -c volume \
                -t 1000 \
                "Volume" "$msg"
else
    msg="󰕾 ${volume_percent}%"
    notify-send -h int:value:"$volume_percent" \
                -h string:x-dunst-stack-tag:volume \
                -c volume \
                -t 1000 \
                "Volume" "$msg"
fi