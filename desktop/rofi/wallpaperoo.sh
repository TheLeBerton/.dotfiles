#!/bin/bash

DOTFILES="$HOME/.dotfiles"
THEME="$HOME/.config/rofi/wallpaperoo.rasi"
WALLPAPER_DIR="$HOME/.local/share/wallpapers"


entries=""
count=0
for f in "$WALLPAPER_DIR"/*; do
	name=$(basename "$f" | sed 's/\.[^.]*$//')
	entries+="$name\0icon\x1f$HOME/.cache/wallpaper-thumbs/$(basename $f)\n"
	((count++))
done

chosen=$(echo -e "$entries" | rofi -dmenu -p "" -show-icons \
	-mesg "$count wallpapers  ·  ← →  to navigate" \
	-theme "$THEME") || exit 0

chosen_file=$(basename "$(ls "$WALLPAPER_DIR/$chosen".*)")
swww img "$WALLPAPER_DIR/$chosen_file" --transition-type wipe --transition-duration 1
