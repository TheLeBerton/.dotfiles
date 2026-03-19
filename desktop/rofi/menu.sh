#!/bin/bash


options=" Apps\n Appearance\n Power"
chosen=$(echo -e "$options" | rofi -dmenu -p "Menu" -theme ~/.config/rofi/pywal.rasi)
case $chosen in
	" Apps")
		rofi -show drun -theme ~/.config/rofi/pywal.rasi
		;;
	" Appearance")
		~/.config/rofi/theme.sh
		;;
	" Power")
		wlogout
		;;
esac
