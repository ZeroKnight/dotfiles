########
### Various Shortcuts
############

# Administrative
alias sudo='sudo -E'
alias pacman='sudo pacman'
alias systemctl='sudo systemctl'
alias netctl='sudo netctl'
alias iptraf='sudo iptraf-ng'

# Misc
alias scrot="scrot 'SCREENSHOT_\%m-\%d-\%Y_\%H:\%M:\%S.png' -d3 -q100 -ms -e 'mv \$f ~/Pictures/Screenshots/'"
alias reloadtint2='killall -SIGUSR1 tint2'

########
### Neat Tricks
############

alias userlist='cat /etc/passwd | cut -d":" -f1'
alias grouplist='cat /etc/group | cut -d":" -f1'
alias today='date "+%A, %B %d, %Y"'
alias openports='netstat --all --numeric --programs --inet --inet6'

########
### Saftey Measures
############

alias ln='ln -i'                    # Prompts to remove destination
alias chown='chown --preserve-root' # Prevent recursive on /
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'
