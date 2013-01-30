### Auto-Coloring ##################
#alias dir='dir --color=auto'
#alias vdir='vdir --color=auto'
alias pacman='sudo pacman-color'
alias cpanm='cpanm --sudo --skip-installed'
alias gproc='ps aux | grep -i'

### Disk Checking #################
alias df='df -h'
alias du='du -ch'

### Directories ###################
alias mkdir='mkdir -p'
alias md='mkdir'
alias rd='rmdir'
alias -- -='cd -'

# Push and pop directories on directory stack
alias pu='pushd'
alias po='popd'

# ls Shortcuts
alias ls='ls -hA --color=auto'
alias sl=ls                         # Often screw this up
alias lr='ls -R'                    # Recursive
alias ll='ls -l'
alias lx='ls -BX'                   # Sort by Extension
alias lz='ls -rS'                   # Sort by Size
alias lt='ls -rt'                   # Sort by Date
alias lp='ls | less'
alias lv='ls -ls'                   # long style and human readable sizes (verbose)

### Various Shortcuts #############
# Sudo shortcut
alias sudo='sudo -E'
alias _='sudo'

alias untar='tar -xvf'
alias scrot="scrot 'SCREENSHOT_\%m-\%d-\%Y_\%H:\%M:\%S.png' -d3 -q100 -ms -e 'mv \$f ~/Pictures/Screenshots/'"
alias reloadtint2='killall -SIGUSR1 tint2'

# Show history
alias history='fc -l 1'

### Tricks and 'new' Commands #####
alias userlist='cat /etc/passwd | cut -d":" -f1'
alias grouplist='cat /etc/group | cut -d":" -f1'
alias today='date "+%A, %B %d, %Y"'
alias openports='netstat --all --numeric --programs --inet --inet6'

### Saftey Measures... ############
alias ln='ln -i'                    # Prompts to remove destination
alias chown='chown --preserve-root' # Prevent recursive on /
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'
