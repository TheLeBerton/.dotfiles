#!/bin/bash


options="Gruvbox\nNord\nTokyo Night\nCatppuccin\nDracula\nCatppuccin Latte\nRose Pine Dawn"
chosen=$(echo -e "$options" | rofi -dmenu -p "Theme" -theme ~/.config/rofi/pywal.rasi)
WALLPAPER_DIR="$HOME/.dotfiles/desktop/wallpapers"

case $chosen in
	"Gruvbox")
		wal --theme base16-gruvbox-hard
		swww img "$WALLPAPER_DIR/gruvbox.png" --transition-type wipe --transition-duration 1
		;;
	"Nord")
		wal --theme base16-nord
		swww img "$WALLPAPER_DIR/nord.jpg" --transition-type wipe --transition-duration 1
		;;
	"Tokyo Night")
		wal --theme tokyonight-moon
		swww img "$WALLPAPER_DIR/tokyo-night.jpg" --transition-type wipe --transition-duration 1
		;;
	"Catppuccin")
		wal --theme catppuccin-mocha
		swww img "$WALLPAPER_DIR/catppuccin.jpg" --transition-type wipe --transition-duration 1
		;;
	"Dracula")
		wal --theme base16-dracula
		swww img "$WALLPAPER_DIR/dracula.jpg" --transition-type wipe --transition-duration 1
		;;
	"Catppuccin Latte")
		wal --theme catppuccin-latte -l
		swww img "$WALLPAPER_DIR/catppuccin-latte.jpg" --transition-type wipe --transition-duration 1
		;;
	"Rose Pine Dawn")
		wal --theme rose-pine-dawn -l
		swww img "$WALLPAPER_DIR/rose-pine-dawn.jpg" --transition-type wipe --transition-duration 1
		;;
esac

pywalfox update
$HOME/.config/hypr/apply-colors.sh
