#!/bin/bash

# Unified volume control script
# Usage: volume_control.sh [up|down|mute]

case "$1" in
    up)
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
        ;;
    down)
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
        ;;
    mute)
        wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        ;;
    *)
        echo "Usage: $0 {up|down|mute}"
        exit 1
        ;;
esac

# Show volume popup if available
[ -f ~/.local/scripts/volume-popup.sh ] && ~/.local/scripts/volume-popup.sh