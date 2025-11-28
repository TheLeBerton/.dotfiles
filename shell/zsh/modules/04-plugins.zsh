#!/usr/bin/env zsh

if command -v fzf &>/dev/null; then
	source <(fzf --zsh) 2>/dev/null || {
		[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh
	}
fi

if [[ $IS_MAC -eq 1 ]]; then
	BREW_PREFIX="/opt/homebrew"
elif [[ $IS_42 -eq 1 ]]; then
	BREW_PREFIX="$HOME/.brew"
elif [[ $IS_ASAHI -eq 1 ]]; then
	BREW_PREFIX="opt/homebrew"
else
	if [[ -d "/home/linuxbrew/.linuxbrew" ]]; then
		BREW_PREFIX="/home/linuxbrew/.linuxbrew"
	else
		BREW_PREFIX="/usr"
	fi
fi

load_plugin() {
	local plugin_name="$1"
	local plugin_file="$2"

	local homebrew_path="$BREW_PREFIX/share/$plugin_name/$plugin_file"
	if [[ -f "$homebrew_path" ]]; then
		source "$homebrew_path"
		return 0
	fi
	for plugin_path in "/usr/share/$plugin_name/$plugin_file" "/usr/local/share/$plugin_name/$plugin_file"; do
		if [[ -f "$plugin_path" ]]; then
			source "$plugin_path"
			return 0
		fi
	done
	return 1
}

load_plugin "zsh-syntax-highlighting" "zsh-syntax-highlighting.zsh"
load_plugin "zsh-autosuggestions" "zsh-autosuggestions.zsh"
load_plugin "zsh-history-substring-search" "zsh-history-substring-search.zsh"

unset BREW_PREFIX
unfunction load_plugin
