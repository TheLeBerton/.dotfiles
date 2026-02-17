#!/bin/bash

case "$1" in
	"up")
		brightnessctl s 10%+
		;;
	"down")
		brightnessctl s 10%-
		;;
esac

brightness=$(brightnessctl -m | awk -F, '{print $4}' | tr -d '%')

dunstify -a "brightness" -r 2000 -h int::value:$brightness -u low "Brightness" "${brightness}%"
