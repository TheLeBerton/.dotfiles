#!/bin/bash

# Détection et export de la variable HYPRLAND_INSTANCE_SIGNATURE
HYP_PID=$(ps -u $USER -o pid,comm | grep Hyprland | awk '{print $1}' | head -n 1)
export HYPRLAND_INSTANCE_SIGNATURE=$(tr '\0' '\n' < /proc/$HYP_PID/environ | grep ^HYPRLAND_INSTANCE_SIGNATURE= | cut -d= -f2-)

# Menu options
options="\n⏾\n⏻\n\n⏼"
choice=$(echo -e "$options" | rofi -dmenu -theme ~/.config/rofi/themes/powermenu.rasi -p " Power")

# Actions
case "$choice" in
    "")
        loginctl lock-session
        ;;

    "⏾")
        if [ -n "$HYPRLAND_INSTANCE_SIGNATURE" ]; then
            hyprctl dispatch exit || pkill Hyprland
        else
            pkill Hyprland
        fi
        ;;

    "⏻")
        systemctl poweroff
        ;;

    "")
        systemctl reboot
        ;;

    "⏼")
        systemctl suspend
        ;;
esac
