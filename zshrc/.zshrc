# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

export ZSH="$HOME/.oh-my-zsh"

export RED='\033[0;31m'
export GREEN='\033[0;32m'
export YELLOW='\033[0;33m'
export RESET='\033[0m'

export SCRIPTS="$HOME/.local/scripts"
export DOTFILES="$HOME/.dotfiles"
if [ ! -d $SCRIPTS ]; then
	if [ -d $DOTFILES ]; then
		echo -e "${YELLOW}→\t[Creating scripts directory...]${RESET}"
		ln -s $DOTFILES/scripts $SCRIPTS
		echo -e "${GREEN}✔\t[Scripts directory linked].${RESET}"
	else
		echo -e "${RED}✖\t[No scripts directory found]${RESET}"
	fi
fi

export DEV="$SCRIPTS/conf/dev"
export SECHO="$SCRIPTS/utils/slow_echo"
# source $ZSH/oh-my-zsh.sh

ZSH_THEME="robbyrussell"

plugins=(git)

if [[ "$OSTYPE" == "darwin"* ]]; then
    alias ls='ls -G'
    alias ll='ls -lG'
    alias la='ls -laG'
	alias l='ls -G'
else
    alias ls='ls --color=auto'
    alias ll='ls -l --color=auto'
    alias la='ls -la --color=auto'
	alias l='ls --color=auto'
fi

bindkey -s ^f "$SCRIPTS/tmux-sessionizer\n"

alias zshconf="nvim $HOME/.zshrc"
alias src="source $HOME/.zshrc"
alias addlib="$SCRIPTS/addlib"
alias pushvog="$SCRIPTS/git/push_vog $1 $2"
alias checkpush="$SCRIPTS/git/is_pushed"
alias tk="$SCRIPTS/tasks/task $@"

function cd() {
    builtin cd "$@" || return

    if [ -d ".git" ]; then
        repo_name=$(basename "$(git rev-parse --show-toplevel)")
        branch=$(git rev-parse --abbrev-ref HEAD)
        last_commit=$(git log -1 --pretty=format:"%h - %s (%cr) by %an")

        echo -e "\033[1;32m📁 Repo:\033[0m $repo_name"
        echo -e "\033[1;34m🌿 Branch:\033[0m $branch"
        echo -e "\033[1;33m🕒 Last commit:\033[0m $last_commit"
        echo -e "\033[1;36m🧵 Local branches (Sorted by date):\033[0m"
        git for-each-ref --sort=-committerdate refs/heads/ \
            --format='  - %(refname:short)  ⏱  %(committerdate:relative)  👤  %(authorname)'
        echo ""
    fi
}

"$HOME/.local/scripts/git/pull_all"

