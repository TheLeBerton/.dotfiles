### Environment variables
## OS Specific
case "$OSTYPE" in
	linux-gnu*)
		export PATH=$HOME/.local/bin:$HOME/bin:/usr/local/bin:$PATH
		if [[ -f "$HOME/.brewconfig.zsh" ]]; then
			source $HOME/.brewconfig.zsh
		fi
		;;
	darwin*)
		export PATH="/opt/homebrew/bin:$PATH"
		;;
	*)
		export PATH="$HOME/.local/bin:$PATH"
		;;
esac
## Extra
export LD_LIBRARY_PATH="$HOME/.local/lib:/usr/local/lib64:$LD_LIBRARY_PATH"
export PKG_CONFIG_PATH="$HOME/.local/lib/pkgconfig:$PKG_CONFIG_PATH"
export PATH=/home/leberton/.local/funcheck/host:$PATH

### PROMPT
git_branch() {
    local branch
	branch=$(git symbolic-ref --short HEAD 2>/dev/null) || return
	if git diff --quiet 2>/dev/null; then
		echo "(%F{green}$branch%f)"
	else
		echo "(%F{red}$branch%f)"
	fi
}
setopt PROMPT_SUBST
PROMPT='%~ $(git_branch)❯ '

### FZF integration
if command -v fzf &>/dev/null; then
	source <(fzf --zsh)
fi

### Syntax highlighting
if command -v brew &>/dev/null; then
	HIGHLIGHT="$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
	[[ -f "$HIGHLIGHT" ]] && source "$HIGHLIGHT"
fi

### Keybindings
bindkey -v
bindkey -s ^f "$SCRIPTS/tmux-sessionizer\n"

### Aliases
alias luamake="/home/leberton/lua-language-server/3rd/luamake/luamake"
alias mstest="bash /home/leberton/42_minishell_tester/tester.sh"
