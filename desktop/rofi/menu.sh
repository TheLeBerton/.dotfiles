#!/bin/bash


options=" Apps\n Theme\n Power"
chosen=$(echo -e "$options" | rofi -dmenu -p "Menu" -theme ~/.config/rofi/pywal.rasi)
case $chosen in
	" Apps")
		rofi -show drun -theme ~/.config/rofi/pywal.rasi
		;;
	" Theme")
		~/.config/rofi/theme.sh
		;;
	" Power")
		wlogout
		;;
esac
