#!/usr/bin/env zsh

if [[ $IS_42 -eq 1 ]]; then
	setxkbmap -I$HOME/.xkb -layout real-prog-dvorak
fi
