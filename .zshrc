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
### oh-my-zsh Settings
############

ZSH=$HOME/.oh-my-zsh
ZSH_THEME="gnzh"
CASE_SENSITIVE="false"
DISABLE_AUTO_TITLE="false"
DISABLE_CORRECTION="false"
COMPLETION_WAITING_DOTS="true"

# Load Plugins
plugins=(git screen colored-man extract fasd)
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

