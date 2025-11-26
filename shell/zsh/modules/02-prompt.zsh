#!/usr/bin/env zsh

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git*' formats "%F{3}%f %F{2}%b%f %m%u%c %F{14}%a%f"
zstyle ':vcs_info:*' stagedstr '%F{2}✓%f'
zstyle ':vcs_info:*' unstagedstr '%F{1}✖%f'
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
PROMPT='%F{7}%~%f  ${vcs_info_msg_0_}
%F{3}❯%f '
