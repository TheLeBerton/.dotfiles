#!/usr/bin/env zsh

export SCRIPTS="$HOME/.dotfiles/scripts"

export IS_42=0
export IS_MAC=0
export IS_ASAHI=0
export LINUX_DISTRO=""

if [[ `uname` = "Darwin" ]]; then
	export OS="darwin"
	export IS_MAC=1
elif [[ `uname` = "Linux" ]]; then
	export OS="linux"
	export IS_MAC=0
fi

if [[ $OS = "linux" ]]; then
	if [[ -d /sgoinfre ]] && [[ "$USER" =~ ^[a-z]+$ ]] && [[ ${#USER} -le 8 ]]; then
		export IS_42=1
	fi
	if [[ -f /etc/os-release ]]; then
		LINUX_DISTRO=$(grep '^ID=' /etc/os-release | cut -d'=' -f2 | tr -d '"')
		export LINUX_DISTRO
	fi
fi
