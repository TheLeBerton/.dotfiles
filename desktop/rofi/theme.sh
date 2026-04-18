#!/bin/bash

WALLPAPER_DIR="$HOME/.local/share/wallpapers"
THEME="$HOME/.config/rofi/squared.rasi"
DARK_THEMES=("Gruvbox" "Nord" "Tokyo Night" "Catppuccin Mocha" "Dracula" "Gray")
LIGHT_THEMES=("Catppuccin Latte" "Rose Pine Dawn")

declare -A THEME_DATA=(
	["Gruvbox"]="base16-gruvbox-hard gruvbox.png 0 squared.css gruvbox"
	["Nord"]="base16-nord nord.jpg 0 squared.css nord"
	["Tokyo Night"]="tokyonight-moon tokyo-night.jpg 10 style.css tokyonight-moon"
	["Catppuccin Mocha"]="catppuccin-mocha catppuccin.jpg 10 style.css catppuccin-mocha"
	["Dracula"]="base16-dracula dracula.jpg 0 squared.css dracula"
	["Gray"]="gray gray.jpg 0 squared.css kanagawa-wave"
	["Catppuccin Latte"]="catppuccin-latte catppuccin_latte.jpg 10 style.css catppuccin-latte"
	["Rose Pine Dawn"]="rose-pine-dawn catppuccin_latte.jpg 0 squared.css rose-pine-dawn"
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

	read -r theme_name wallpaper rounding waybar_style nvim_theme <<< "${THEME_DATA[$theme]}"
	wal --theme "$theme_name" $flags
	swww img "$WALLPAPER_DIR/$wallpaper" --transition-type wipe --transition-duration 1
	pywalfox update
	$HOME/.config/hypr/apply-colors.sh "$waybar_style" "$nvim_theme"
	hyprctl keyword decoration:rounding "$rounding"
}

pick_da_theeme
