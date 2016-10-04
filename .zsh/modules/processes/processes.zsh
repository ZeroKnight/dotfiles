# ps Aliases and Shortcuts

# "Default" options to use for standard ps alias
ps_opts='-efly'

# Like `ps | grep foo`, but shorter and less ugly
# eval expands $ps_opts
eval "psg() {
  local pids=\"\$(pgrep -d, \$1)\"
  [ -n \"\$pids\" ] || return 1
  command ps ${ps_opts/e/} -p \"\$pids\"
}"

alias ps="ps $ps_opts | less"
alias psf='\ps -elfy --forest | less'
alias psv='\ps --forest -eo uid,pid,ppid,c,pcpu,pmem,rsz,psr,stime,time,tty,cmd | less'
alias psm='\ps -eo rss,cmd | sort -b -nr | less'
alias psc='\ps -eo pcpu,c,nice,stat,time,cmd | sort -k1,1r | less'

# Clean up
unset ps_opts
