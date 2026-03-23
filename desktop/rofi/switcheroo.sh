#!/bin/bash

THEME=~/.config/rofi/pywal.rasi

ANALOG_SINK="alsa_output.pci-0000_07_00.4.analog-stereo"
HEADPHONE_PORT="analog-output-headphones"
SPEAKER_PORT="analog-output-lineout"

set_port() {
	local port="$1"
	pactl set-sink-port "$ANALOG_SINK" "$port"
}


switch_sound() {
	choice=$(printf "Headphone\nSpeaker" | rofi -dmenu -p "choose audio" -theme "$THEME")
	case $choice in
		"Headphone")
			set_port "$HEADPHONE_PORT" ;;
		"Speaker")
			set_port "$SPEAKER_PORT" ;;
	esac
}


switch_sound
