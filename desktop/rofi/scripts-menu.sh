#!/bin/bash

THEME="~/.config/rofi/pywal.rasi"
DOTFILES="$HOME/.dotfiles"

declare -A scripts=(
		["Toggle Waybar"]="$DOTFILES/desktop/waybar/scripts/launch_me.sh"
		["Switcheroo"]="$DOTFILES/desktop/rofi/switcheroo.sh"
)

chosen=$(printf '%s\n' "${!scripts[@]}" | rofi -dmenu -p "Scripts" -theme "$THEME")
echo "Chosen script: $chosen"
[ -n "$chosen" ] && "${scripts[$chosen]}"
