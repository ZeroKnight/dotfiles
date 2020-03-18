# ps Aliases and Shortcuts

# Holds format specifiers with friendly names for -o switch
local -A fs=(
  [cmd]='cmd=COMMAND'
  [euser]='euser:12'
  [ruser]='ruser:12'
  [stat]='stat=STATE'
  [suser]='suser:12'
  [time]='time=CPU_TIME'
  [tty]='tty=TTY'
  [vsz]='vsz=VRSS'
)

local -A common=(
  [cpu]="ni,psr,%cpu"
  [mem]="%mem,rss,$fs[vsz]"
  [tail]="$fs[stat],$fs[tty],start,$fs[time],$fs[cmd]"
)

export PS_PERSONALITY='linux'
export PS_FORMAT="f,$fs[euser],pid,ppid,nlwp,$common[cpu],$common[mem],$common[tail]"

alias ps='ps --forest'
alias psm='command ps --sort=-rss'
alias psc='command ps --sort=-%cpu'
alias psj="ps -t $(tty) -o f,pid,ppid,pgid,sid,$common[tail]"
alias psuser="ps f,$fs[euser],$fs[ruser],$fs[suser],egroup,rgroup,sgroup,$common[tail]"
alias pstty='ps -N -t -'
alias pstime="ps -o f,$fs[euser],pid,ppid,$fs[stat],lstart,$fs[time],$fs[cmd]"
