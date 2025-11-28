#!/usr/bin/env zsh

for luamake_path in \
	"$HOME/lua-language-server/3rd/luamake/luamake" \
	"$HOME/.local/bin/luamake" \
	"/usr/local/bin/luamake"; do
	if [[ -x "$luamake_path" ]]; then
		alias luamake="$luamake_path"
		break
	fi
done

if [[ $OS = "darwin" ]]; then
	if [[ -f "$HOME/42_minishell_tester/tester.sh" ]]; then
		alias mstest="bash $HOME/42_minishell_tester/tester.sh"
	fi
fi

alias vim="nvim"
alias vi="nvim"
alias v="nvim"

# Navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias ~="cd ~"
alias ll="ls -la"
alias la="ls -la"
alias grep="grep --color=auto"

if command -v bat &>/dev/null; then
	alias cat="bat"
fi

# Zoxide - smarter cd
if command -v zoxide &>/dev/null; then
	eval "$(zoxide init zsh --cmd cd)"
fi

# Enhanced grep
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"

# Useful shortcuts
alias h="history"
alias c="clear"
alias reload="source ~/.zshrc"

# System info
alias myip="curl ifconfig.me"
alias ports="lsof -i -P | grep LISTEN"
