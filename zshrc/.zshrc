if [[ "$OSTYPE" == "linux-gnu"* ]]; then
	export PATH=$HOME/.local/bin:$HOME/bin:/usr/local/bin:$PATH
	export PATH=$HOME/neovim/bin:$PATH
elif [[ "$OSTYPE" == "darwin"* ]]; then
	export PATH="/opt/homebrew/bin:$PATH"
fi
export ZSH="$HOME/.oh-my-zsh"                                      
                                                                                                   
export RED='\033[0;31m'                                             
export GREEN='\033[0;32m'                                          
export YELLOW='\033[0;33m'                                         
export RESET='\033[0m'                                             
                                                                                                   
export SCRIPTS="$HOME/.local/scripts"                                  
export DOTFILES="$HOME/.dotfiles"                                      
export DEV="$SCRIPTS/conf/dev"									   
export SECHO="$SCRIPTS/utils/slow_echo"							   

autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats '(%b)'
zstyle ':vcs_info:git:*' check-for-changes true
precmd() {
    vcs_info

    local staged=0 unstaged=0 untracked=0 ahead=0 behind=0
    if [[ -n $(git diff --cached --name-only 2>/dev/null) ]]; then staged=1; fi
    if [[ -n $(git diff --name-only 2>/dev/null) ]]; then unstaged=1; fi
    if [[ -n $(git ls-files --others --exclude-standard 2>/dev/null) ]]; then untracked=1; fi
    ahead=$(git rev-list --count @{u}..HEAD 2>/dev/null || echo 0)
    behind=$(git rev-list --count HEAD..@{u} 2>/dev/null || echo 0)
    local flags=""
    (( staged )) && flags+=" s"
    (( unstaged )) && flags+=" us"
    (( untracked )) && flags+=" ut"
    (( ahead > 0 )) && flags+="↑$ahead"
    (( behind > 0 )) && flags+="↓$behind"

	local branch_name="${vcs_info_msg_0_:-}"
	branch_name=${branch_name//\(/}
	branch_name=${branch_name//\)/}

	local color="green"
	if (( staged + unstaged + untracked > 0 )); then
		color="red"
	fi

	local branch=""
	if [[ -n $flags ]]; then
		branch="%F{$color}($branch_name$flags)%f"
	elif [[ -n $branch_name ]]; then
		branch="%F{$color}($branch_name)%f"
	fi

	local venv=""
	if [[ -n "$VIRTUAL_ENV" ]]; then
		venv="($(basename $VIRTUAL_ENV)) "
	fi

	if [[ -n $branch && -n $venv ]]; then
		PS1="${venv}[%~] $branch $ "
	elif [[ -n $branch ]]; then
		PS1="[%~] $branch $ "
	elif [[ -n $venv ]]; then
		PS1="${venv}[%~] $ "
	else
		PS1="[%~] $ "
	fi
}

ZSH_THEME="robbyrussell"
plugins=(git)

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
	source $HOME/.brewconfig.zsh
fi
source <(fzf --zsh)

bindkey -s ^f "$SCRIPTS/tmux-sessionizer\n"                                                        
export PATH=/home/leberton/.local/funcheck/host:$PATH
