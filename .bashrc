#!/bin/bash

# Append to HISTFILE, not overwrite
shopt -s histappend

# Checks window size after each command; updates LINES & COLUMNS
# if necessary
shopt -s checkwinsize

## Alias Definitions ##
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

## Function Definitions ##
if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi

## Set EDITOR ##
if [ "$DISPLAY" ]
then
    EDITOR=gvim
else
    EDITOR=vim
fi


##########
# Prompt #
##########

if [ -n "$SSH_CLIENT" ]; then
        PS1='\[\e[1;34m\][\t] \[\e[1;30m\]<\[\e[1;32m\]\u\[\e[0;35m\]@\[\e[1;32m\]\h\[\e[1;30m\]> [\[\e[1;36m\]\w\[\e[1;30m\]]\n\[\e[1;32m\]SSH\$\[\e[0;32m\] '
else  #default prompt
        PS1='\[\e[1;34m\][\t] \[\e[1;30m\]<\[\e[1;32m\]\u\[\e[0;35m\]@\[\e[1;32m\]\h\[\e[1;30m\]> [\[\e[1;36m\]\w\[\e[1;30m\]]\n\[\e[1;32m\]\$\[\e[0;32m\] '
fi

PROMPT_COMMAND='history -a'


##################
# Color Settings #
##################

### Set DIRCOLORS ###
#eval "$(dircolors -b /etc/DIR_COLORS)"

### Set Color Aliases ###
# Reset
nocol='\e[0m'           # Text Reset

# Regular Colors
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White

# Bold
BBlack='\e[1;30m'       # Black
BRed='\e[1;31m'         # Red
BGreen='\e[1;32m'       # Green
BYellow='\e[1;33m'      # Yellow
BBlue='\e[1;34m'        # Blue
BPurple='\e[1;35m'      # Purple
BCyan='\e[1;36m'        # Cyan
BWhite='\e[1;37m'       # White

# Underline
UBlack='\e[4;30m'       # Black
URed='\e[4;31m'         # Red
UGreen='\e[4;32m'       # Green
UYellow='\e[4;33m'      # Yellow
UBlue='\e[4;34m'        # Blue
UPurple='\e[4;35m'      # Purple
UCyan='\e[4;36m'        # Cyan
UWhite='\e[4;37m'       # White

# Background
On_Black='\e[40m'       # Black
On_Red='\e[41m'         # Red
On_Green='\e[42m'       # Green
On_Yellow='\e[43m'      # Yellow
On_Blue='\e[44m'        # Blue
On_Purple='\e[45m'      # Purple
On_Cyan='\e[46m'        # Cyan
On_White='\e[47m'       # White

# High Intensty
IBlack='\e[0;90m'       # Black
IRed='\e[0;91m'         # Red
IGreen='\e[0;92m'       # Green
IYellow='\e[0;93m'      # Yellow
IBlue='\e[0;94m'        # Blue
IPurple='\e[0;95m'      # Purple
ICyan='\e[0;96m'        # Cyan
IWhite='\e[0;97m'       # White

# Bold High Intensty
BIBlack='\e[1;90m'      # Black
BIRed='\e[1;91m'        # Red
BIGreen='\e[1;92m'      # Green
BIYellow='\e[1;93m'     # Yellow
BIBlue='\e[1;94m'       # Blue
BIPurple='\e[1;95m'     # Purple
BICyan='\e[1;96m'       # Cyan
BIWhite='\e[1;97m'      # White

# High Intensty backgrounds
On_IBlack='\e[0;100m'   # Black
On_IRed='\e[0;101m'     # Red
On_IGreen='\e[0;102m'   # Green
On_IYellow='\e[0;103m'  # Yellow
On_IBlue='\e[0;104m'    # Blue
On_IPurple='\e[10;95m'  # Purple
On_ICyan='\e[0;106m'    # Cyan


##################
# man() Coloring #
##################

man() {

    # Less Colors for Man Pages:
    # _mb = begin blinking
    # _md = begin bold
    # _me = end mode
    # _se = end standout-mode
    # _so = begin standout-mode - info box
    # _ue = end underline
    # _us = begin underline

	env \
		LESS_TERMCAP_mb=$(printf "\e[1;31m") \
		LESS_TERMCAP_md=$(printf "\e[1;31m") \
		LESS_TERMCAP_me=$(printf "\e[0m") \
		LESS_TERMCAP_se=$(printf "\e[0m") \
		LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
		LESS_TERMCAP_ue=$(printf "\e[0m") \
		LESS_TERMCAP_us=$(printf "\e[1;32m") \
			man "$@"
}


########
# Misc #
########
# Greet with a nice fortune :)
fortune

