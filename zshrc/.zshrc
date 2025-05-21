# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

export ZSH="$HOME/.oh-my-zsh"
# source $ZSH/oh-my-zsh.sh

ZSH_THEME="robbyrussell"

plugins=(git)

bindkey -s ^f "$HOME/.local/scripts/tmux-sessionizer\n"

alias zshconf="nvim ~/.zshrc"
alias src="source ~/.zshrc"
alias addlib="~/.dotfiles/scripts/addlib"
alias pushvog="$HOME/.local/scripts/push_vog $1 $2"
