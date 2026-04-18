#!/bin/bash

DOTFILES="$HOME/.dotfiles"
CONFIG="$HOME/.config"
BIN="$HOME/.local/bin"

BACKUPS=()

SUCCESS="✔"
ERROR="✘"
WARNING="⚠"
ARROW="➔"

log_success_link() {
	from="$1"
	to="$2"
	echo -e "\t${ARROW} linked from ${from} to ${to}"
}

log_backup() {
	path="$1"
	echo -e "\t\t${WARNING} backed up $path"
}

log_section() {
	section="$1"
	echo -e "\n[ ${section} ]"
}

link() {
	path_from="$DOTFILES/$1"
	path_to="$2"
	mkdir -p "$(dirname "$path_to")"
	if [[ -L "$path_to" ]]; then
		rm "$path_to"
	elif [[ -e "$path_to" ]]; then
		mv "$path_to" "$path_to.bak"
		BACKUPS+=("$path_to.bak")
		log_backup "$path_to"
	fi
	ln -sf "$path_from" "$path_to"
	log_success_link "$path_from" "$path_to"
}

OS=""
IS_42=0

detect_os() {
	log_section "OS"
	if [[ $(uname) = "Darwin" ]]; then
		OS="darwin"
	elif [[ $(uname) = "Linux" ]]; then
		OS="linux"
		if [[ -d /sgoinfre ]] && [[ "$USER" =~ ^[a-z]+$ ]] && [[ ${#USER} -le 8 ]]; then
			IS_42=1
		fi
	fi
	echo -e "	${ARROW} detected: ${OS}"
}

link_shell() {
	log_section "shell"
	link "shell/zsh/.zshrc" "$HOME/.zshrc"
	link "shell/zsh/.zprofile" "$HOME/.zprofile"
	link "shell/starship/starship.toml" "$CONFIG/starship/starship.toml"
}

link_git() {
	log_section "git"
	link "git/config" "$HOME/.gitconfig"
	link "git/ignore" "$CONFIG/git/ignore"
	link "git/.gitmessage.txt" "$HOME/.gitmessage.txt"
}

link_scripts() {
	log_section "scripts"
	for file in "$DOTFILES/scripts/utils"/*; do
		to="$BIN/$(basename "$file")"
		ln -sf "$file" "$to"
		log_success_link "$file" "$to"
	done
}

link_desktop() {
	log_section "desktop"
	link "desktop/hypr" "$CONFIG/hypr"
	link "desktop/waybar" "$CONFIG/waybar"
	link "desktop/rofi" "$CONFIG/rofi"
	link "desktop/swaync" "$CONFIG/swaync"
	link "desktop/wal" "$CONFIG/wal"
}

link_os_specific() {
	if [[ $IS_42 -eq 0 ]]; then
		log_section "no 42"
		link "terminal/kitty/kitty.conf" "$CONFIG/kitty/kitty.conf"
		if command -v hyprctl &>/dev/null; then
			link_desktop
		fi
		link_scripts
	fi
}

show_backups() {
	log_section "backups"
	for backup in "${BACKUPS[@]}"; do
		echo -e "	${ARROW} $backup"
	done
	echo -e
}

main() {
	detect_os
	link_shell
	link_git
	link "nvim" "$HOME/.config/nvim"
	link "terminal/tmux/.tmux.conf" "$HOME/.tmux.conf"
	link_os_specific
	show_backups
	echo -e "\n[ TODO ] source $HOME/.zshrc"
}

main

