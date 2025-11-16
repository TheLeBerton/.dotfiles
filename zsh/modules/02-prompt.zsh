#!/usr/bin/env zsh

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git*' formats " %F{blue}%b%f %m%u%c %a"
zstyle ':vcs_info:*' stagedstr ' %F{green}●%f'
zstyle ':vcs_info:*' unstagedstr ' %F{red}●%f'
setopt PROMPT_SUBST
precmd()
{
	if [[ $(git rev-parse --is-inside-work-tree 2>/dev/null) == "true" ]]; then
		vcs_info
	else
		vcs_info_msg_0_=""
	fi
	print -P
}
PROMPT='%F{cyan}%~%f ${vcs_info_msg_0_}
%F{green}❯%f '
