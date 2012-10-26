## Auto-Color ##
#alias dir='dir --color=auto'
#alias vdir='vdir --color=auto'
alias grep='grep --color=auto --exclude-dir=".svn"'
alias fgrep='fgrep --color=auto --exclude-dir=".svn"'
alias egrep='egrep --color=auto --exclude-dir=".svn"'
alias pacman='sudo pacman-color'


## Shortcuts ##
alias df='df -h'
alias du='du -ch'
alias mkdir='mkdir -pv'
alias ping='ping -c 5'
alias ..='cd ..'
alias md='mkdir'
alias rd='rmdir'
alias untar='tar -xvf'
alias sudo='sudo -E'
alias scrot="scrot 'SCREENSHOT_\%m-\%d-\%Y_\%H:\%M:\%S.png' -d3 -q100 -ms -e 'mv \$f ~/Pictures/Screenshots/'"

## ls Modifications ##
alias ls='ls -hA --color=auto'
alias lr='ls -R'                    # Recursive
alias ll='ls -l'
alias lx='ls -BX'                   # Sort by Extension
alias lz='ls -rS'                   # Sort by Size
alias lt='ls -rt'                   # Sort by Date
alias lm='ls | less'
alias lv='ls -ls'                   # long style and human readable sizes (verbose)

## New Commands ##
alias userlist='cat /etc/passwd | cut -d":" -f1'
alias grouplist='cat /etc/group | cut -d":" -f1'
alias today='date "+%A, %B %d, %Y"'
alias hist='history | grep $1'
alias openports='netstat --all --numeric --programs --inet --inet6'

## Games ##
alias steam='wine ~/.wine/drive_c/Program\ Files\ \(x86\)/Steam/Steam.exe -no-dwrite >/dev/null 2>&1 &'

## Safety Features ##
#alias cp='cp -i'                    # Always prompt for overwrite
#alias mv='mv -i'
alias rm='rm -I'                    # Prompts ONCE when removing 3+ files
alias ln='ln -i'                    # Prompts to remove destination
alias chown='chown --preserve-root' # Prevent recursive on /
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'
