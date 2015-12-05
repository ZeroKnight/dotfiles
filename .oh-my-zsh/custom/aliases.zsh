alias v='vim'
alias t='tmux attach-session -t'
alias md='mkdir -vp'

# Administrative shortcuts
alias pacman='sudo pacman'
alias aptg='sudo apt-get'
alias aptc='sudo apt-cache'
alias systemctl='sudo systemctl'
alias netctl='sudo netctl'

# ps Shortcuts
# TODO: Figure out better aliases (better options)
alias ps='ps -elfy | less'
alias psf='\ps -elfy --forest | less'
alias psv='\ps --forest -eo uid,pid,ppid,c,pcpu,pmem,rsz,psr,stime,time,tty,cmd | less'
alias psm='\ps -eo rss,cmd | sort -b -nr | less'
alias psc='\ps -eo pcpu,c,nice,stat,time,cmd | sort -k1,1r | less'

# Pipe shortcuts
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g L="| less"
alias -g LL='2>&1 | less'
alias -g NE='2>/dev/null'
alias -g NUL='&>/dev/null'

# Quick Screenshot
alias screenshot="maim -s \"~/Pictures/Screenshots/SCREENSHOT_$(date '+%F_%T').png\""
alias screenshotf="maim \"~/Pictures/Screenshots/SCREENSHOT_$(date '+%F_%T').png\""

# Misc
alias userlist='cat /etc/passwd | cut -d":" -f1 | sort'
alias grouplist='cat /etc/group | cut -d":" -f1 | sort'

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
