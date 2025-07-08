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
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '(%b)'
export PS1="[%~] ${vcs_info_msg_0} $ "

ZSH_THEME="robbyrussell"
plugins=(git)

source $HOME/.brewconfig.zsh
source <(fzf --zsh)

bindkey -s ^f "$SCRIPTS/tmux-sessionizer\n"                                                        
export PATH=/home/leberton/.local/funcheck/host:$PATH
