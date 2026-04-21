#!/bin/bash

DOTFILES="$HOME/.dotfiles"

is_connected() {
	ping -c 1 -W 2 google.com > /dev/null 2>&1
}

if ! is_connected; then
	exit 0
fi

git -C "$DOTFILES" fetch --quiet 2>/dev/null
behind=$(git -C "$DOTFILES" rev-list --count HEAD..@{u})
if [[ $behind -ne 0 ]]; then
	echo "[ DOTFILES ] $behind commits behind origin"
fi


