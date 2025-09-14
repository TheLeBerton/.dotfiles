#!/bin/bash
# Dotfiles linking script

set -e

DOTFILES_DIR="$HOME/.dotfiles"
CONFIG_DIR="$HOME/.config"
LOCAL_DIR="$HOME/.local"

echo "🔗 Linking dotfiles..."

# Create directories if they don't exist
mkdir -p "$CONFIG_DIR" "$LOCAL_DIR"

# Config symlinks
declare -A config_links=(
    ["hypr"]="$CONFIG_DIR/hypr"
    ["kitty"]="$CONFIG_DIR/kitty"
    ["waybar"]="$CONFIG_DIR/waybar"
    ["nvim"]="$CONFIG_DIR/nvim"
    ["rofi"]="$CONFIG_DIR/rofi"
    ["tmux"]="$CONFIG_DIR/tmux"
    ["dunst"]="$CONFIG_DIR/dunst"
    ["mako"]="$CONFIG_DIR/mako"
    ["rmpc"]="$CONFIG_DIR/rmpc"
)

# Local symlinks
declare -A local_links=(
    ["scripts"]="$LOCAL_DIR/scripts"
)

# Home symlinks
declare -A home_links=(
    ["zshrc/.zshrc"]="$HOME/.zshrc"
    ["zshrc/.zprofile"]="$HOME/.zprofile"
    ["zshrc/.bashrc"]="$HOME/.bashrc"
)

# Function to create symlink safely
create_link() {
    local source="$1"
    local target="$2"

    if [[ -L "$target" ]]; then
        echo "  ✓ $target (already linked)"
        return
    fi

    if [[ -e "$target" ]]; then
        echo "  ⚠️  $target exists, backing up to ${target}.backup"
        mv "$target" "${target}.backup"
    fi

    ln -sf "$source" "$target"
    echo "  ✓ $target -> $source"
}

# Link config files
echo "📁 Linking config files..."
for source in "${!config_links[@]}"; do
    if [[ -d "$DOTFILES_DIR/$source" ]]; then
        create_link "$DOTFILES_DIR/$source" "${config_links[$source]}"
    fi
done

# Link local files
echo "📂 Linking local files..."
for source in "${!local_links[@]}"; do
    if [[ -d "$DOTFILES_DIR/$source" ]]; then
        create_link "$DOTFILES_DIR/$source" "${local_links[$source]}"
    fi
done

# Link home files
echo "🏠 Linking home files..."
for source in "${!home_links[@]}"; do
    if [[ -f "$DOTFILES_DIR/$source" ]]; then
        create_link "$DOTFILES_DIR/$source" "${home_links[$source]}"
    fi
done

echo "✅ Dotfiles linking complete!"

# Optional: restart services
if command -v waybar >/dev/null 2>&1; then
    echo "🔄 Restarting Waybar..."
    pkill waybar 2>/dev/null || true
    sleep 1
    waybar >/dev/null 2>&1 &
fi

if command -v dunst >/dev/null 2>&1; then
    echo "🔄 Restarting Dunst..."
    pkill dunst 2>/dev/null || true
    sleep 1
    dunst >/dev/null 2>&1 &
fi

echo "🎉 All done! Your dotfiles are now properly linked."