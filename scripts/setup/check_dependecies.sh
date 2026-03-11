#!/bin/bash

MAGENTA='\033[0;35m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CLEAR='\033[0m'


log_info() {
	echo -e "${MAGENTA}[INFO]${CLEAR} $1"
}

log_warning() {
	echo -e "${YELLOW}[WARNING]${CLEAR} $1"
}

log_error() {
	echo -e "${RED}[ERROR]${CLEAR} $1"
}


is_command_here() {
	if command -v $1 &> /dev/null; then
		return 0
	fi
	return 1
}


has_sudo() {
	sudo -n true 2>/dev/null
}

get_package_manager() {
	if command -v brew &> /dev/null && ! has_sudo; then
		echo "brew"
	elif command -v apt &> /dev/null && has_sudo; then
		echo "apt"
	elif command -v dnf &> /dev/null && has_sudo; then
		echo "dnf"
	elif command -v brew &> /dev/null; then
		echo "brew"
	else
		log_error "No supported package manager found with sufficient privileges. Install brew (no sudo needed) or run with sudo."
		exit 1
	fi
}


install_package() {
	package_manager=$(get_package_manager) || exit 1
	case "$package_manager" in
		apt)
			sudo apt update && sudo apt install -y "$1"
			;;
		dnf)
			sudo dnf install -y "$1"
			;;
		brew)
			brew install "$1"
			;;
	esac
}


handle_dependency_check() {
	if ! is_command_here "$1"; then
		log_error "$1 is not installed. Installing $1..."
		install_package "$1"
	else
		log_info "$1 is installed."
	fi
}



check_dependencies() {
	log_info "Checking for required dependencies..."
	# check_system

	handle_dependency_check "ssh"
	handle_dependency_check "zsh"
	handle_dependency_check "git"
	handle_dependency_check "nvim"
	handle_dependency_check "fzf"
	handle_dependency_check "rg"
	handle_dependency_check "clangd"
	handle_dependency_check "tmux"
	handle_dependency_check "pgrep"
}

main() {
	check_dependencies
}

main
