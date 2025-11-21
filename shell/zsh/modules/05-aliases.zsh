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

if [[ $OS = "darwin" ]]; then
	if [[ -f "$HOME/42_minishell_tester/tester.sh" ]]; then
		alias mstest="bash $HOME/42_minishell_tester/tester.sh"
	fi
fi

alias ll="ls -la"
alias la="ls -la"
alias grep="grep --color=auto"

if [[ $IS_MAC -eq 1 ]]; then
	alias ls="ls -G"
else
	alias ls="ls --color=auto"
fi
