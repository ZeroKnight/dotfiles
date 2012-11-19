#=============][==============>>
# ZeroKnight's .zshrc file 
#=============][=============>>

# oh-my-zsh pretty much handles all of this beautifully :)
# Yay for modularity!!

### oh-my-zsh Settings #############
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"
CASE_SENSITIVE="false"
COMPLETION_WAITING_DOTS="true"

plugins=(git)

source $ZSH/oh-my-zsh.sh

### zsh Settings ##################
# BELL BEEPS ARE EVIL. DIE.
setopt no_beep
setopt no_list_beep

setopt auto_cd
setopt cdablevars

### Environment Settings ##########
export PAGER='less -R'
export EDITOR='vim'
