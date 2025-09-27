#!/bin/bash

brightness_percent=$(brightnessctl | awk -F'[%()]' '{gsub(/ /,"",$2); print $2}' | xargs)
msg="󰃠 ${brightness_percent}%"

notify-send -h int:value:"$brightness_percent" \
		-h string:x-dunst-stack-tag:brightness \
		-c brightness \
		-t 1000 \
		"Brightness" "$msg"


