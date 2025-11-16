#!/usr/bin/env zsh

export PATH="$HOME/.local/bin:$HOME/bin:/usr/local/bin:/usr/bin:/bin:$PATH"

if [[ $IS_MAC -eq 1 ]]; then
	export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
elif [[ $OS = "linux" ]]; then
	if [[ $IS_42 -eq 1 ]]; then
		export PATH="$HOME/.brew/bin:$PATH"
		[[ -f "$HOME/.brewconfig.zsh" ]] && source "$HOME/.brewconfig.zsh"
	elif [[ $IS_ASAHI -eq 1 ]]; then
		export PATH="/opt/homebrew/bin:$PATH"
	else
		export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
	fi
	if [[ $LINUX_DISTRO = "ubuntu" ]]; then
		export PATH="/snap/bin:$PATH"
	fi
fi
