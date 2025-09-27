#!/bin/bash

# Simple volume control for Asahi Linux
# Directly modify system volume files

case "$1" in
    up|down|mute)
        # Use system volume keys directly
        if command -v osascript >/dev/null 2>&1; then
            # If macOS commands available
            case "$1" in
                up) osascript -e "set volume output volume (output volume of (get volume settings) + 5)" ;;
                down) osascript -e "set volume output volume (output volume of (get volume settings) - 5)" ;;
                mute) osascript -e "set volume output muted not (output muted of (get volume settings))" ;;
            esac
        else
            # Try Asahi Linux specific approach
            case "$1" in
                up)
                    # Try multiple approaches
                    amixer -c 1 set Headphone on 2>/dev/null
                    amixer -c 1 set Speaker on 2>/dev/null
                    amixer set Master 5%+ 2>/dev/null
                    wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ 2>/dev/null
                    ;;
                down)
                    # Try multiple approaches
                    amixer -c 1 set Headphone on 2>/dev/null
                    amixer -c 1 set Speaker on 2>/dev/null
                    amixer set Master 5%- 2>/dev/null
                    wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- 2>/dev/null
                    ;;
                mute)
                    # Check current mute status and toggle properly
                    if amixer get Master 2>/dev/null | grep -q '\[off\]'; then
                        # Currently muted, unmute
                        amixer set Master on 2>/dev/null
                        wpctl set-mute @DEFAULT_AUDIO_SINK@ 0 2>/dev/null
                    else
                        # Currently unmuted, mute
                        amixer set Master off 2>/dev/null
                        wpctl set-mute @DEFAULT_AUDIO_SINK@ 1 2>/dev/null
                    fi
                    ;;
            esac
        fi
        ;;
    *)
        echo "Usage: $0 {up|down|mute}"
        exit 1
        ;;
esac

# Show notification
~/.local/scripts/volume-popup.sh