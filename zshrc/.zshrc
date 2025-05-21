# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

export ZSH="$HOME/.oh-my-zsh"
export DEV="$HOME/.dotfiles/scripts/conf/all"
# source $ZSH/oh-my-zsh.sh

ZSH_THEME="robbyrussell"

plugins=(git)

bindkey -s ^f "$HOME/.local/scripts/tmux-sessionizer\n"

alias zshconf="nvim $HOME/.zshrc"
alias src="source $HOME/.zshrc"
alias addlib="$HOME/.dotfiles/scripts/addlib"
alias pushvog="$HOME/.local/scripts/push_vog $1 $2"
alias checkpush="$HOME/.local/scripts/is_pushed"
alias tk="$HOME/.local/scripts/tasks/task $@"

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
