#!/usr/bin/env zsh

autoload -Uz compinit
if [[ -n ~/.zcompdump(#qn.mh+24) ]]; then
  compinit
else
  compinit -C
fi

zstyle ":completion:*" menu select
zstyle ":completion:*" matcher-list 'm:{a-z}={A-Za-z}'
zstyle ":completion:*" list-colors "${(s.:.)LS_COLORS}"
zstyle ":completion:*" group-name ''

zmodload zsh/complist

_comp_options+=(globdots)

zstyle ':completion:*:cd:*' ignore-parents parent pwd
zstyle ':completion:*' squeeze-slashes true
