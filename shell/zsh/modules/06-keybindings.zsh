#!/usr/bin/env zsh

bindkey -v

if [[ -n "$SCRIPTS" && -f "$SCRIPTS/tmux-sessionizer" ]]; then
	bindkey -s '^f' "$SCRIPTS/tmux-sessionizer\n"
fi

if command -v history-substring-search-up &>/dev/null; then
	bindkey '^[[A' history-substring-search-up
	bindkey '^[[B' history-substring-search-down
fi
