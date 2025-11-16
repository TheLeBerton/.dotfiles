#!/usr/bin/env zsh

DOTFILES_DIR="$HOME/.dotfiles"

for module in "$DOTFILES_DIR"/zshrc/modules/*.zsh; do
	if [[ -r "$module" ]]; then
		source "$module"
	fi
done

[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"
[[ -f "$DOTFILE_DIR/local/.zshrc.$OS" ]] && source "$DOTFILE_DIR/local/.zshrc.$OS"

unset DOTFILES_DIR
