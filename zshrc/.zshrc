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

## Colors
autoload -Uz colors && colors

### PROMPT
autoload -Uz vcs_info
zstyle ':vcs_info:git*' formats " %F{blue}%b%f %m%u%c %a"
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr ' %F{green}+%f'
zstyle ':vcs_info:*' unstagedstr ' %F{red}-%f'
setopt PROMPT_SUBST
precmd()
{
	vcs_info
	print -P '%B%~%b ${vcs_info_msg_0_}'
}
PROMPT='%B%(!.#.>)%b '

# git_branch() {
#     local branch
# 	branch=$(git symbolic-ref --short HEAD 2>/dev/null) || return
# 	if git diff --quiet 2>/dev/null; then
# 		echo "(%F{green}$branch%f)"
# 	else
# 		echo "(%F{red}$branch%f)"
# 	fi
# }
# setopt PROMPT_SUBST
# PROMPT='%~ $(git_branch)❯ '

### Completion
autoload -Uz compinit
zstyle ":completion:*" menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

### FZF integration
if command -v fzf &>/dev/null; then
	source <(fzf --zsh)
fi

### Syntax highlighting
if command -v brew &>/dev/null; then
	HIGHLIGHT="$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
	[[ -f "$HIGHLIGHT" ]] && source "$HIGHLIGHT"
	AUTOSUGGESTIONS="$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
	[[ -f "$AUTOSUGGESTIONS" ]] && source "$AUTOSUGGESTIONS"
	HISTORY_SUBSTRING_SEARCH="$(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh"
	[[ -f "$HISTORY_SUBSTRING_SEARCH" ]] && source "$HISTORY_SUBSTRING_SEARCH"
fi

### Keybindings
bindkey -v
bindkey -s ^f "$SCRIPTS/tmux-sessionizer\n"

### Aliases
alias luamake="/home/leberton/lua-language-server/3rd/luamake/luamake"
alias mstest="bash /home/leberton/42_minishell_tester/tester.sh"
alias vim="nvim"
alias vi="nvim"
alias v="nvim"
