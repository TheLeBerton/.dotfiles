#!/bin/bash

if pgrep -x waybar > /dev/null
then
	pkill waybar
else
	echo "Starting Waybar..."
	waybar -c ~/.config/waybar/config.json &
fi
