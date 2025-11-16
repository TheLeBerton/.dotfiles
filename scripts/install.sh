#!/bin/bash

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

log() { echo -e "${BLUE}[DOTFILES]${NC} $1"; }
success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; exit 1; }

log "Starting dotfiles installation..."

case "$(uname -s)" in
	Darwin*)	OS="mac" ;;
	Linux*)		OS="linux" ;;
	*)			error "Unsupported OS: $(uname -s)" ;;
esac

if [[ -d "/sgoinfre" && "$USER" =~ ^[a-z]+$ && ${#USER} -le 8 ]]; then
	ENV="42"
elif [[ "$OS" == "linux" && -f "/proc/device-tree/compatible" ]] && grep -q "apple" /proc/device-tree/compatible 2>/dev/null; then
	ENV="asahi"
else
	ENV="standard"
fi

log "Detected OS: $OS ($ENV environment)"

install_essentials() {
	log "Installing essential packages..."

	case "$OS-$ENV" in
		mac-*)
			if ! command -v brew &>/dev/null; then
				log "Homebrew not found. Installing Homebrew..."
				/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
			fi
			brew install fzf neovim tmux git curl wget
			brew install zsh-syntax-highlighting zsh-autosuggestions zsh-history-substring-search
			;;
		linux-42)
			log "Setting up 42 environment..."
			if [[ ! -f "$HOME/.brewconfig.zsh" ]]; then
				warning "Brew config not found. Please set up Homebrew manually for 42 environment."
				return 1
			fi
			;;
		linux-asahi)
			log "Setting up Asahi environment..."
			sudo dnf install -y fzf neovim tmux git curl wget
			;;
		linux-standard)
			if command -v apt &>/dev/null; then
				sudo apt update
				sudo apt install -y fzf neovim tmux git curl wget
			elif command -v dnf &>/dev/null; then
				sudo dnf install -y fzf neovim tmux git curl wget
			elif command -v pacman &>/dev/null; then
				sudo pacman -S --needed fzf neovim tmux git curl wget
			else
				error "Unsupported package manager. Please install essentials manually."
			fi
			;;
	esac
}

setup_dotfiles() {
	log "Setting up dotfiles..."
	for file in ~/.zshrc ~/.zprofile; do
		if [[ -f "$file" && ! -L "$file" ]]; then
			backup="$file.backup.$(date +%s)"
			log "Backing up existing $file to $backup"
			mv "$file" "$backup"
		fi
	done
	ln -sf "$HOME/.dotfiles/zsh/.zshrc" "$HOME/.zshrc"
	if [[ "$SHELL" != *"zsh" ]]; then
		log "Changing default shell to zsh..."
		chsh -s "$(which zsh)"
	fi
}

verify_setup() {
	log "Verifying installation..."

	if [[ -L ~/.zshrc ]]; then
		success "zshrc symlink created"
	else
		error "zshrc symlink failed"
	fi
	for cmd in fzf nvim tmux git; do
		if command -v "$cmd" &>/dev/null; then
			success "$cmd installed"
		else
			warning "$cmd not found in PATH"
		fi
	done
}

main() {
	install_essentials
	setup_dotfiles
	verify_setup

	success "Dotfiles installation completed successfully!"
}

main "$@"
