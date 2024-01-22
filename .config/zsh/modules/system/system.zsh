#
# System administration aliases et al
#

### Sudo

# Explicitly expand aliases when using sudo (see `man zshmisc`)
alias sudo='sudo '

# Implicit sudo shortcuts
alias pacman='sudo pacman'
alias apt='sudo apt'
alias aptg='sudo apt-get'
alias aptc='sudo apt-cache'
alias zyp='sudo zypper'

### Systemd

alias sysc='systemctl'
alias sysc='systemctl --user'
alias jctl='journalctl'

### Misc

alias userlist='cut -d":" -f1 /etc/passwd | sort | column'
alias grouplist='cut -d":" -f1 /etc/group | sort | column'

# Pipe/Redirect shortcuts
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g L="| less"
alias -g LL='2>&1 | less'
alias -g NE='2>/dev/null'
alias -g NUL='&>/dev/null'

### Saftey Measures

# Prompts to remove destination
alias ln='ln -i'

# Prevent recursive on /
alias rm='rm -I --preserve-root'
alias chown='chown -v --preserve-root'
alias chmod='chmod -v --preserve-root'
alias chgrp='chgrp -v --preserve-root'
