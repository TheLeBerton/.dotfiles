#!/bin/bash
# Idle management script with swayidle

# Check if swayidle is installed
if ! command -v swayidle >/dev/null 2>&1; then
    notify-send "Idle Error" "swayidle is not installed"
    exit 1
fi

# Kill any existing swayidle processes
pkill swayidle

# Start swayidle with custom timeouts
swayidle -w \
    timeout 300 'brightnessctl s 10%' \
        resume 'brightnessctl s 50%' \
    timeout 600 '~/.local/scripts/lock.sh' \
    timeout 900 'hyprctl dispatch dpms off' \
        resume 'hyprctl dispatch dpms on' \
    before-sleep '~/.local/scripts/lock.sh' &

echo "Idle management started"