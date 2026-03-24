#!/bin/bash

WALLPAPER_DIR="$HOME/.dotfiles/desktop/wallpapers"
THEME="$HOME/.config/rofi/squared.rasi"
DARK_THEMES=("Gruvbox" "Nord" "Tokyo Night" "Catppuccin Mocha" "Dracula")
LIGHT_THEMES=("Catppuccin Latte" "Rose Pine Dawn")

declare -A THEME_DATA=(
	["Gruvbox"]="base16-gruvbox-hard gruvbox.png"
	["Nord"]="base16-nord nord.jpg"
	["Tokyo Night"]="tokyonight-moon tokyo-night.jpg"
	["Catppuccin Mocha"]="catppuccin-mocha catppuccin.jpg"
	["Dracula"]="base16-dracula dracula.jpg"
	["Catppuccin Latte"]="catppuccin-latte catppuccin_latte.jpg"
	["Rose Pine Dawn"]="rose-pine-dawn catppuccin_latte.jpg"
)

pick_da_theeme() {
	local mode
	mode=$(printf 'Dark\nLight' | rofi -dmenu -p "Mode" -theme "$THEME")
	[ -z "$mode" ] && return

	local theme flags=""
	if [[ "$mode" == "Light" ]]; then
		theme=$(printf '%s\n' "${LIGHT_THEMES[@]}" | rofi -dmenu -p "Choose Theme" -theme "$THEME")
		flags="-l"
	else
		theme=$(printf '%s\n' "${DARK_THEMES[@]}" | rofi -dmenu -p "Choose Theme" -theme "$THEME")
	fi
	[ -z "$theme" ] && return

	read -r theme_name wallpaper <<< "${THEME_DATA[$theme]}"
	wal --theme "$theme_name" $flags
	swww img "$WALLPAPER_DIR/$wallpaper" --transition-type wipe --transition-duration 1
	pywalfox update
	$HOME/.config/hypr/apply-colors.sh
}

pick_da_theeme
