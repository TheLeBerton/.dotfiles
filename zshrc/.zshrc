if [[ "$OSTYPE" == "linux-gnu"* ]]; then
	export PATH=$HOME/.local/bin:$HOME/bin:/usr/local/bin:$PATH
	export PATH=$HOME/neovim/bin:$PATH
elif [[ "$OSTYPE" == "darwin"* ]]; then
	export PATH="/opt/homebrew/bin:$PATH"
fi

export SCRIPTS="$HOME/.local/scripts"
export DOTFILES="$HOME/.dotfiles"

# Minimal prompt: ~ ❯
PS1='%~ ❯ '

# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"  # Not used due to custom PS1
plugins=(git)

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
	source $HOME/.brewconfig.zsh
fi

# FZF integration
source <(fzf --zsh)

# Key bindings
bindkey -s ^f "$SCRIPTS/tmux-sessionizer\n"

export PATH=/home/leberton/.local/funcheck/host:$PATH