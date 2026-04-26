#!/bin/bash

THEME="~/.config/rofi/squared.rasi"

rofi -modi combi \
	-combi-modi "menu:~/.config/rofi/custom_menu.sh,drun" \
	-show combi \
	-show-icons \
	-theme "$THEME"
