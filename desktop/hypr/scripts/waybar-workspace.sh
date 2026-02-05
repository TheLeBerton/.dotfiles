#!/bin/bash

STATEFILE="/tmp/waybar-hidden"
rm -f "$STATEFILE"

socat -U - UNIX-CONNECT:"$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" | while read -r line; do
	if echo "$line" | grep -qE "^workspace>>"; then
		workspace="${line#workspace>>}"
		echo "DEBUG: workspace='$workspace' statefile=$([ -f "$STATEFILE" ] && echo 'exists' || echo 'missing')" >> /tmp/waybar-debug.log
		if [ "$workspace" = "3" ] && [ ! -f "$STATEFILE" ]; then
			killall -SIGUSR1 waybar
			touch "$STATEFILE"
		elif [ "$workspace" != "3" ] && [ -f "$STATEFILE" ]; then
			killall -SIGUSR1 waybar
			rm -f "$STATEFILE"
		fi
	fi
done
