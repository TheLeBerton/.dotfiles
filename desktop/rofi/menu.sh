#!/bin/bash

THEME="~/.config/rofi/squared.rasi"

options=" Apps\n Theme\n Scripts\n Power"
chosen=$(echo -e "$options" | rofi -dmenu -p "Menu" -theme "$THEME")
case $chosen in
	" Apps")
		rofi -show drun -show-icons -theme "$THEME"
		;;
	" Theme")
		~/.config/rofi/theme.sh
		;;
	" Scripts")
		~/.config/rofi/scripts-menu.sh
		;;
	" Power")
		wlogout
		;;
esac
