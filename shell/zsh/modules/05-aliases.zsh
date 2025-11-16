#!/usr/bin/env zsh

alias vim="nvim"
alias vi="nvim"
alias v="nvim"

for luamake_path in \
	"$HOME/lua-language-server/3rd/luamake/luamake" \
	"$HOME/.local/bin/luamake" \
	"/usr/local/bin/luamake"; do
	if [[ -x "$luamake_path" ]]; then
		alias luamake="$luamake_path"
		break
	fi
done

if [[ $OS = "linux" ]]; then
	for test_path in "$HOME/42_minishell_tester/tester.sh"; do
		if [[ -f "$test_path" ]]; then
			alias mstest="bash $test_path"
			break
		fi
	done
fi

# Navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias ~="cd ~"

# Modern alternatives (with fallbacks)
if command -v eza &>/dev/null; then
	alias ls="eza --icons"
	alias ll="eza -la --icons"
	alias la="eza -la --icons"
	alias tree="eza --tree"
else
	if [[ $OS == "darwin" ]]; then
		alias ls="ls -G"
	else
		alias ls="ls --color=auto"
	fi
	alias ll="ls -la"
	alias la="ls -la"
fi

if command -v bat &>/dev/null; then
	alias cat="bat"
fi

if command -v zoxide &>/dev/null; then
	alias cd="z"
fi

# Enhanced grep
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"

# Useful shortcuts
alias h="history"
alias c="clear"
alias reload="source ~/.zshrc"
alias doctor="$HOME/.dotfiles/scripts/utils/doctor.sh"

# Git shortcuts (in addition to existing git config)
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gl="git log --oneline"

# System info
alias myip="curl ifconfig.me"
alias ports="lsof -i -P | grep LISTEN"
