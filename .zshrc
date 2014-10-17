#   _____                   __ __       _       __    __ _
#  /__  /  ___  _________  / //_/____  (_)___ _/ /_  / /( )_____
#    / /  / _ \/ ___/ __ \/ ,<  / __ \/ / __ `/ __ \/ __/// ___/
#   / /__/  __/ /  / /_/ / /| |/ / / / / /_/ / / / / /_  (__  )
#  /____/\___/_/   \____/_/ |_/_/ /_/_/\__, /_/ /_/\__/ /____/
#                                __   /____/
#                    ____  _____/ /_  __________
#                   /_  / / ___/ __ \/ ___/ ___/
#                  _ / /_(__  ) / / / /  / /__
#                 (_)___/____/_/ /_/_/   \___/
#

########
### Preliminary Setup & Helpers
############

# Do we have this program?
isAvailable() {
    whence -p $1 &>/dev/null
}

isAvailableRun() {
    whence -p $1 &>/dev/null && $1
}

########
### oh-my-zsh Settings
############

ZSH=$HOME/.oh-my-zsh
ZSH_THEME="gnzh"
CASE_SENSITIVE="false"
DISABLE_AUTO_TITLE="true"
DISABLE_CORRECTION="false"
COMPLETION_WAITING_DOTS="true"

# Load Plugins
# TODO: Modify vundle plugin?
plugins=(git vi-mode colored-man extract fasd command-not-found cpanm)
if [[ "$(uname -o)" == 'Cygwin' ]]; then
    plugins+=cygwin
fi

# Let oh-my-zsh do its thing
source $ZSH/oh-my-zsh.sh

########
### zsh Settings
############

# BELL BEEPS ARE EVIL. DIE.
setopt no_beep
setopt no_list_beep

setopt auto_cd
setopt cdablevars

########
### Interactive Environment Settings
############

# NOTE: This may need to be moved or re-worked
export TERM='screen-256color'

# `less` Settings
export PAGER='less'
export LESS='-R'

########
### Run core programs
############

# Display a lovely fortune
isAvailableRun fortune

# Start keychain
if [ -z "$SSH" ] && isAvailable keychain; then
    eval $(keychain --eval --agents ssh -Q ~/.ssh/*.key)
fi

# Powerline
source /usr/share/zsh/site-contrib/powerline.zsh

