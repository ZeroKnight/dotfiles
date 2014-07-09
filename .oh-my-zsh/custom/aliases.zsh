# Administrative shortcuts
alias pacman='sudo pacman'
alias aptg='sudo apt-get'
alias aptc='sudo apt-cache'
alias systemctl='sudo systemctl'
alias netctl='sudo netctl'

# ps Shortcuts
alias ps='ps -ef'
alias psf='ps --forest'
alias psl='\ps -ely'
alias psv='\ps --forest -eo uid,pid,ppid,c,pcpu,pmem,rsz,psr,stime,time,tty,cmd'
alias psm='\ps -eo rss,cmd | sort -b -nr'
alias psc='\ps -eo pcpu,c,nice,stat,time,cmd | sort -k1,1r'

# Quick tail
alias t='tail -F'

# Pipe shortcuts
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g L="| less"
alias -g LL="2>&1 | less"
alias -g NE="2>/dev/null"
alias -g NUL="&>/dev/null"

# Quick Screenshot
alias scrot="scrot 'SCREENSHOT_%m-%d-%Y_%H:%M:%S.png' -d3 -q100 -ms -e 'mv \$f ~/Pictures/Screenshots/'"
alias scrotf="\scrot 'SCREENSHOT_%m-%d-%Y_%H:%M:%S.png' -d3 -q100 -m -e 'mv \$f ~/Pictures/Screenshots/'"

# Misc
alias reloadtint2='killall -SIGUSR1 tint2'
alias userlist='cat /etc/passwd | cut -d":" -f1'
alias grouplist='cat /etc/group | cut -d":" -f1'

# Suffix Aliases
if [ ${ZSH_VERSION//\./} -ge 420 ]; then
    # open browser on urls
    _browser_fts=(htm html de org net com at cx nl se dk dk php)
    for ft in $_browser_fts ; do alias -s $ft=$BROWSER ; done

    # open images
    _image_fts=(jpg jpeg png gif mng tiff tif xpm)
    for ft in $_image_fts ; do alias -s $ft=$XIVIEWER; done

    #_media_fts=(avi mpg mpeg ogm mp3 wav ogg ape rm mov mkv)
    #for ft in $_media_fts ; do alias -s $ft=mplayer ; done
fi

# Saftey Measures
alias ln='ln -i'                    # Prompts to remove destination
alias chown='chown --preserve-root' # Prevent recursive on /
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'
