#!/bin/bash

case "$1" in
	"up")
		wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
		;;
	"down")
		wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
		;;
	"mute")
		wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
		;;
esac

volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2 * 100)}')
muted=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -c MUTED)

if [ $muted -eq 1 ]; then
	dunstify -a "Volume" -r 1000 -h int::value:0 -u low "Volume" "Muted"
else
	dunstify -a "Volume" -r 1000 -h int::value:$volume -u low "Volume" "$volume%"
fi
