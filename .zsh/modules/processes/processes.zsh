# ps Aliases and Shortcuts

export PS_PERSONALITY='linux'
export PS_FORMAT='stat,euser:12,pid,ppid,time=CPU_TIME,nlwp,ni,%cpu,%mem,rss,vsz=VRSS,stime,tty=TTY,cmd=COMMAND'

alias ps='ps -e'
alias psf='ps --forest'
alias psm='ps --sort=-rss'
alias psc='ps --sort=-%cpu'

