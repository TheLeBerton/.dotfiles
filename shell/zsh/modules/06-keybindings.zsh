#!/usr/bin/env zsh

bindkey -v

if [[ -n "$SCRIPTS" && -f "$SCRIPTS/utils/tmux-sessionizer" ]]; then
	bindkey -s '^f' "$SCRIPTS/utils/tmux-sessionizer\n"
fi

if command -v history-substring-search-up &>/dev/null; then
	bindkey '^[[A' history-substring-search-up
	bindkey '^[[B' history-substring-search-down
fi
