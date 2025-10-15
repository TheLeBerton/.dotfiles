# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
	export PATH=$HOME/.local/bin:$HOME/bin:/usr/local/bin:$PATH
	export PATH=$HOME/neovim/bin:$PATH
elif [[ "$OSTYPE" == "darwin"* ]]; then
	export PATH="/opt/homebrew/bin:$PATH"
fi

export SCRIPTS="$HOME/.local/scripts"
export DOTFILES="$HOME/.dotfiles"

# Minimal prompt with git branch: ~ (branch) ❯
git_branch() {
    local branch=$(git symbolic-ref --short HEAD 2>/dev/null)
    if [[ -n "$branch" ]]; then
        if git diff --quiet 2>/dev/null; then
            echo "(%F{green}$branch%f)"
        else
            echo "(%F{red}$branch%f)"
        fi
    fi
}

setopt PROMPT_SUBST
PROMPT='%~ $(git_branch)❯ '

# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"  # Not used due to custom PS1
plugins=(git)
source $ZSH/oh-my-zsh.sh

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
	source $HOME/.brewconfig.zsh
fi

# FZF integration
source <(fzf --zsh)

# Key bindings
bindkey -s ^f "$SCRIPTS/tmux-sessionizer\n"

export PATH=/home/leberton/.local/funcheck/host:$PATH
source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export PATH="$HOME/.local/bin:$PATH"
export LD_LIBRARY_PATH="$HOME/.local/lib:/usr/local/lib64:$LD_LIBRARY_PATH"
export PKG_CONFIG_PATH="$HOME/.local/lib/pkgconfig:$PKG_CONFIG_PATH"
