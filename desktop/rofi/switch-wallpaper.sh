#!/bin/bash

DOTFILES="$HOME/.dotfiles"
WALLPAPER_DIR="$DOTFILES/desktop/wallpapers"


entries=""
for f in $DOTFILES/desktop/wallpapers/*; do
	name=$(basename "$f" | sed 's/\.[^.]*$//') # basename without extension
	entries+="$name\0icon\x1f$HOME/.cache/wallpaper-thumbs/$(basename $f)\n"
done

chosen=$(echo -e "$entries" | rofi -dmenu -p "Switch Wallpaper" -show-icons \
	-theme ~/.config/rofi/wallpaper-switcher.rasi) || exit 0

chosen_file=$(basename "$(ls "$WALLPAPER_DIR/$chosen".*)")
swww img "$WALLPAPER_DIR/$chosen_file" --transition-type wipe --transition-duration 1
