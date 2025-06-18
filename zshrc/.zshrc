								#############################
								#                           #
								# #######  ######   ####	#
								#  ##   #  # ## #    ##		#
								#  ## #      ##      ##		#
								#  ####      ##      ##		#
								#  ## #      ##      ##   # #
								#  ##        ##      ##  ## #
								# ####      ####    ####### #
								#                           #
								#############################
								
					# ASCII ART from: https://en.rakko.tools/tools/68/

####################################################################################################
#                                                                                                  # 
#																##                                 #
#																##                                 # 
#				  ####    ##  ##   ######    ####    ######    #####    #####                      #
#				 ##  ##    ####     ##  ##  ##  ##    ##  ##    ##     ##                          #
#				 ######     ##      ##  ##  ##  ##    ##        ##      #####                      #
#				 ##        ####     #####   ##  ##    ##        ## ##       ##                     # 
#				  #####   ##  ##    ##       ####    ####        ###   ######                      #
#								   ####	                                                           #
#																						           #
####################################################################################################
					# If you come from bash you might have to change your $PATH.
					# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH


							# PATH
							if [[ "$OSTYPE" == "linux-gnu"* ]]; then
						export PATH=$HOME/.local/bin:$HOME/bin:/usr/local/bin:$PATH
							elif [[ "$OSTYPE" == "darwin"* ]]; then
								export PATH="/opt/homebrew/bin:$PATH"
							fi
								export ZSH="$HOME/.oh-my-zsh"                                      
                                                                                                   
								# Colors
								export RED='\033[0;31m'                                             
								export GREEN='\033[0;32m'                                          
								export YELLOW='\033[0;33m'                                         
								export RESET='\033[0m'                                             
                                                                                                   
							# scripts and dotfiles
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
								
							# Slow echo
							export SECHO="$SCRIPTS/utils/slow_echo"							   

								# dev
								export DEV="$SCRIPTS/conf/dev"									   

								# git config
								export XDG_CONFIG_HOME="$HOME/.config"

								# terminal prompt
								autoload -Uz vcs_info
								precmd() { vcs_info }
								zstyle ':vcs_info:git:*' formats '(%b)'
		function virtualenv_info() { [[ -n "$VIRTUAL_ENV" ]] && echo "($(basename $VIRTUAL_ENV))" }
								setopt PROMPT_SUBST
					export PS1='[%~] $(virtualenv_info) ${vcs_info_msg_0_} $ '


####################################################################################################

								# source $ZSH/oh-my-zsh.sh
								ZSH_THEME="robbyrussell"

								plugins=(git)

####################################################################################################
#                                								                                   #
#						   ###       ##                                                            #
#							##                                                                     #
#				  ####      ##      ###      ####     #####    ####     #####                      #
#					 ##     ##       ##         ##   ##       ##  ##   ##                          #
#				  #####     ##       ##      #####    #####   ######    #####                      #
#				 ##  ##     ##       ##     ##  ##        ##  ##            ##                     #
#				  #####    ####     ####     #####   ######    #####   ######                      #
#                                                                                                  #
####################################################################################################
                                                                                                   
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
alias zshconf="nvim $HOME/.zsrc" 														           
alias src="source $HOME/.zshrc" 														           
alias addlib="$SCRIPTS/addlib" 														               
alias pushvog="$SCRIPTS/git/push_vog $1 $2"														   
alias checkpush="$SCRIPTS/git/is_pushed" 													      
alias tk="$SCRIPTS/tasks/task $@"																   

alias gs="git status --short"
alias gd="git --no-pager diff --output-indicator-new=' ' --output-indicator-old=' '"
alias ga="git add"
alias gap="git add --patch"
alias gc="git commit"
alias gp="git push"
alias gu="git pull"
alias gl="git log --all --graph --pretty=format:'%C(magenta)%h %C(white) %an %ar%C(auto) %D%n%s%n'"
alias gb="git branch"


####################################################################################################


####################################################################################################
#																								   #
#			 ###        ##                 ###     ##                                              #
#			  ##                            ##                                                     #
#			  ##       ###     #####        ##    ###     #####     ### ##   #####                 #
#			  #####     ##     ##  ##    #####     ##     ##  ##   ##  ##   ##                     #
#			  ##  ##    ##     ##  ##   ##  ##     ##     ##  ##   ##  ##    #####                 #
#			  ##  ##    ##     ##  ##   ##  ##     ##     ##  ##    #####        ##                #
#			 ######    ####    ##  ##    ######   ####    ##  ##       ##   ######                 #
#																   #####						   #
#																							       #
####################################################################################################
																								   
bindkey -s ^f "$SCRIPTS/tmux-sessionizer\n"                                                        
####################################################################################################


