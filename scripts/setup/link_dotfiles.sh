#!/bin/bash


MAGENTA='\033[0;35m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CLEAR='\033[0m'

DOTFILES_DIR="$HOME/.dotfiles"


log_info() {
	echo -e "${MAGENTA}[INFO]${CLEAR} $1"
}

log_warning() {
	echo -e "${YELLOW}[WARNING]${CLEAR} $1"
}

log_error() {
	echo -e "${RED}[ERROR]${CLEAR} $1"
}


log_dotfile_linking() {
	if [ $? -ne 0 ]; then
		log_error "Failed to link $1. Please check if the file exists and try again."
		exit 1
	else
		log_info "$1 linked successfully."
	fi
}

link_dotfiles() {
	log_info "Linking dotfiles from $DOTFILES_DIR to home directory..."
	mkdir -p "$HOME/.config"

	log_info "Linking .zshrc..."
	log_info "Removing existing .zshrc if it exists..."
	rm -f "$HOME/.zshrc"
	ln -s "$DOTFILES_DIR/shell/zsh/.zshrc" "$HOME/.zshrc"
	log_dotfile_linking ".zshrc"

	log_info "Linking .tmux.conf..."
	ln -s "$DOTFILES_DIR/editors/nvim/" "$HOME/.config/nvim"
	log_dotfile_linking "nvim"

	log_info "Linking .tmux.conf..."
	ln -s "$DOTFILES_DIR/terminal/tmux/.tmux.conf" "$HOME/.tmux.conf"
	log_dotfile_linking ".tmux.conf"
}

is_dotfiles_cloned() {
	if [ -d "$DOTFILES_DIR" ]; then
		return 0
	fi
	return 1
}


check_system() {
	if [[ "$(uname)" != "Linux" && "$(uname)" != "Darwin" ]]; then
		log_error "Unsupported operating system: $(uname). This setup script only supports Linux and macOS."
		exit 1
	fi
}




main() {
	if ! is_dotfiles_cloned; then
		log_error "Dotfiles repository not found. Please clone the repository to $DOTFILES_DIR and try again."
		exit 1
	fi
	check_system
	link_dotfiles
}

main
