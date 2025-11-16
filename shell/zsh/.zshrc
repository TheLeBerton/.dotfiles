#!/usr/bin/env zsh

DOTFILES_DIR="$HOME/.dotfiles"

for module in "$DOTFILES_DIR"/zsh/modules/*.zsh; do
	if [[ -r "$module" ]]; then
		source "$module"
	fi
done

[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"
[[ -f "$DOTFILES_DIR/local/.zshrc.$OS" ]] && source "$DOTFILES_DIR/local/.zshrc.$OS"

unset DOTFILES_DIR
