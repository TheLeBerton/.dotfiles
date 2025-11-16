#!/bin/bash
# Screen lock script with swaylock

# Check if swaylock is installed
if ! command -v swaylock >/dev/null 2>&1; then
    notify-send "Lock Error" "swaylock is not installed"
    exit 1
fi

# Lock the screen with custom config
swaylock --config ~/.config/swaylock/config