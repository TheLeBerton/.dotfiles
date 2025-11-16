#!/bin/bash

# set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
PURPLE='\033[0;35m'
NC='\033[0m'

log() { echo -e "${BLUE}[LOG]${NC} $1"; }
success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; exit 1; }
section() { echo -e "\n${PURPLE}=== $1 ===${NC}\n"; }

DOTFILES="${HOME}/.dotfiles"
INSTALL_ALL=false
INSTALL_DEV=false
INSTALL_DESKTOP=false
INSTALL_ZSH=false

parse_args() {
	while [[ $# -gt 0 ]]; do
		case $1 in
			--all)		INSTALL_ALL=true; shift ;;
			--dev)		INSTALL_DEV=true; shift ;;
			--desktop)	INSTALL_DESKTOP=true; shift ;;
			--zsh)		INSTALL_ZSH=true; shift ;;
			--help)		show_help; exit 0 ;;
			*)			error "Unknown option: $1"; shift ;;
		esac
	done
	if [[ "$INSTALL_DEV" == false && "$INSTALL_DESKTOP" == false && "$INSTALL_ZSH" == false ]]; then
		INSTALL_ALL=true
	fi
}

show_help() {
	cat << EOF
Usage: $0 [OPTIONS]

Options:
	--all		Install everything (default)
	--dev		Install only development tools (nvim, tmux, git)
	--desktop	Install only desktop environment (hyprland, waybar, etc.)
	--zsh		Install only zsh configuration
	--help		Show this help message

Examples:
	$0					# Install everything
	$0 --dev			# Install only dev tools
	$0 --zsh --dev		# Install zsh and dev tools
EOF
}

detect_environment() {
	section "Environment Detection"

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

	NEEDS_DESKTOP=false
	if [[ "$OS" == "linux" && -n "$XDG_CURRENT_DESKTOP" ]] || [[ -f "/usr/bin/Xorg" ]] || [[ -n "$WAYLAND_DISPLAY" ]]; then
		NEEDS_DESKTOP=true
	fi

	log "Detected OS: $OS ($ENV environment)"
	[[ "$NEEDS_DESKTOP" == true ]] && log "Desktop environment detected"
}

install_base_packages() {
	section "Installing Base Packages"

	set +e
	case "$OS-$ENV" in
		mac-*)
			if ! command -v brew &>/dev/null; then
				log "Installing Homebrew..."
				/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
			fi
			brew install git curl wget
			;;
		linux-42)
			log "42 environment detected. Assuming packages are available."
			;;
		linux-*)
			if command -v apt &>/dev/null; then
				sudo apt update && sudo apt install -y git curl wget
			elif command -v dnf &>/dev/null; then
				sudo dnf install -y git curl wget
			elif command -v pacman &>/dev/null; then
				sudo pacman -S --needed curl wget git
			fi
			;;
	esac
	set -e
	success "Base packages installed"
}

install_dev_tools() {
	section "Installing Development Tools"
	case "$OS-$ENV" in
		mac-*)
			brew install neovim tmux fzf ripgrep fd
			brew install zsh-syntax-highlighting zsh-autosuggestions zsh-history-substring-search
			;;
		linux-42)
			if [[ ! -f "$HOME/.brewconfig.zsh" ]]; then
				warning "Please run 42's brew setup first"
				return 1
			fi
			;;
		linux-*)
			if command -v apt &>/dev/null; then
				sudo apt install -y neovim tmux fzf ripgrep fd-find
			elif command -v dnf &>/dev/null; then
				sudo dnf install -y neovim tmux fzf ripgrep fd-find
			elif command -v pacman &>/dev/null; then
				sudo pacman -S --needed neovim tmux fzf ripgrep fd
			fi
			;;
	esac
	if ! command -v node &>/dev/null; then
		log "Installing Node.js via nvm..."
		case "$OS" in
			mac) brew install node ;;
			linux)
				curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
				sudo apt-get install -y nodejs || sudo dnf install -y nodejs || true
				;;
		esac
	fi
	success "Development tools installed"
}

install_desktop_environment() {
	[[ "$OS" != "linux" ]] && { log "Skipping desktop setup on macOS"; return 0; }
	[[ "$NEEDS_DESKTOP" == false ]] && { log "No desktop environment detected, skipping"; return 0; }

	section "Installing Desktop Environment"

	if command -v apt &>/dev/null; then
		sudo apt install -y hyprland waybar rofi kitty mako-notifier swaylock-effects
		sudo apt install -y fonts-noto fonts-noto-color-emoji
	elif command -v dnf &>/dev/null; then
		sudo dnf install -y hyprland waybar rofi kitty mako swaylock-effects
		sudo dnf install -y google-noto-fonts google-noto-emoji-fonts
	elif command -v pacman &>/dev/null; then
		sudo pacman -S --needed hyprland waybar rofi kitty mako swaylock-effects
		sudo pacman -S --needed noto-fonts noto-fonts-emoji
	fi

	success "Desktop environment installed"
}

setup_dotfiles_links() {
	section "Setting up Configuration Links"

	local configs=(".zshrc" ".zprofile" ".tmux.conf" ".gitconfig")
	for config in "${configs[@]}"; do
		if [[ -f "$HOME/$config" && ! -L "$HOME/$config" ]]; then
			backup="$HOME/$config.backup.$(date +%s)"
			log "Backing up existing $config to $backup"
			mv "$HOME/$config" "$backup"
		fi
	done

	ln -sf "$DOTFILES/shell/zsh/.zshrc" "$HOME/.zshrc"
	ln -sf "$DOTFILES/shell/zsh/.zprofile" "$HOME/.zprofile"

	if [[ "$INSTALL_ALL" == true || "$INSTALL_DEV" == true ]]; then
		ln -sf "$DOTFILES/terminal/tmux/.tmux.conf" "$HOME/.tmux.conf"
		ln -sf "$DOTFILES/dev/git/config" "$HOME/.gitconfig"
		ln -sf "$DOTFILES/dev/git/ignore" "$HOME/.gitignore_global"

		[[ -d "$HOME/.config" ]] || mkdir -p "$HOME/.config"
		ln -sf "$DOTFILES/editors/nvim" "$HOME/.config/nvim"
		ln -sf "$DOTFILES/terminal/kitty" "$HOME/.config/kitty"
	fi

	if [[ "$OS" == "linux" && ("$INSTALL_ALL" == true || "$INSTALL_DESKTOP" == true) ]]; then
		[[ -d "$HOME/.config" ]] || mkdir -p "$HOME/.config"

		local desktop_configs=("hyprland" "waybar" "rofi" "mako" "swaylock")
		for config in "${desktop_configs[@]}"; do
			ln -sf "$DOTFILES/desktop/$config" "$HOME/.config/$(basename $config)"
		done
	fi

	success "Configuration links set up"
}

setup_tmux_plugins() {
	[[ "$INSTALL_DEV" == false && "$INSTALL_ALL" == false ]] && return 0

	section "Setting up tmux plugins"

	local tpm_dir="$HOME/.tmux/plugins/tpm"
	if [[ ! -d "$tpm_dir" ]]; then
		log "Cloning tmux plugin manager..."
		git clone https://github.com/tmux-plugins/tpm "$tpm_dir"
	fi

	if command -v tmux &>/dev/null; then
		log "Installing tmux plugins..."
		"$tpm_dir/bin/install_plugins" || true
	fi

	success "Tmux plugins configured"
}

setup_neovim() {
	[[ "$INSTALL_DEV" == false && "$INSTALL_ALL" == false ]] && return 0
	section "Setting up Neovim"
	local lazy_dir="$HOME/.local/share/nvim/lazy/lazy.nvim"
	if [[ ! -d "$lazy_dir" ]]; then
		log "Installing lazy.nvim..."
		git clone --filter=blob:none --single-branch \
			https://github.com/folke/lazy.nvim.git "$lazy_dir"
	fi
	if command -v nvim &>/dev/null; then
		log "Installing Neovim plugins..."
		nvim --headless "+Lazy! install" +qa || true
	fi
	success "Neovim configured"
}

setup_shell() {
	section "Setting up Zsh plugins"
	if [[ "$SHELL" != *"zsh"* ]]; then
		log "Setting zsh as default shell..."
		chsh -s "$(which zsh)" || warning "Failed to change default shell"
	fi
	find "$DOTFILES/scripts" -name "*.sh" -exec chmod +x {} \; 2>/dev/null || true
	success "Zsh setup complete"
}

run_health_check() {
	section "Running Health Check"

	local issues=0
	local links=("$HOME/.zshrc")
	[[ "$INSTALL_DEV" == true || "$INSTALL_ALL" == true ]] && links+=("$HOME/.tmux.conf" "$HOME/.gitconfig")
	for link in "${links[@]}"; do
		if [[ -L "$link" ]]; then
			success "$(basename "$link") linked correctly"
		else
			warning "$link is not a symlink"
			((issues++))
		fi
	done
	local commands=("git" "zsh")
	[[ "$INSTALL_DEV" == true || "$INSTALL_ALL" == true ]] && commands+=("nvim" "tmux" "fzf")
	for cmd in "${commands[@]}"; do
		if command -v "$cmd" &>/dev/null; then
			success "$cmd is installed"
		else
			warning "$cmd not found"
			((issues++))
		fi
	done
	if [[ $issues -eq 0 ]]; then
		success "Health check passed with no issues"
	else
		warning "Health check completed with $issues issues"
	fi
}

main() {
	log "Starting dotfiles setup..."

	parse_args "$@"
	detect_environment
	install_base_packages

	[[ "$INSTALL_ALL" == true || "$INSTALL_DEV" == true ]] && install_dev_tools
	[[ "$INSTALL_ALL" == true || "$INSTALL_DESKTOP" == true ]] && install_desktop_environment

	setup_dotfiles_links

	[[ "$INSTALL_ALL" == true || "$INSTALL_DEV" == true ]] && {
		setup_tmux_plugins
		setup_neovim
	}

	setup_shell
	run_health_check

	section "Setup Complete."
	[[ "$OS" == "linux" ]] && log "You may need to restart your display manager for desktop changes."
}

[[ "${BASH_SOURCE[0]}" == "${0}" ]] && main "$@"
