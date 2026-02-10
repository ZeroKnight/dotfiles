function fkill --description 'Choose process to kill via fzf'
    set -f format 'euser:12,ruser:12,pid,ppid,ni,stat=STATE,tty=TTY,lstart,time=CPU_TIME,cmd=COMMAND'

    set -f binds 'enter:execute(kill {3})+abort'
    set -a binds 'alt-1:execute(kill -s USR1 {3})+abort'
    set -a binds 'alt-2:execute(kill -s USR2 {3})+abort'
    set -a binds 'alt-k:execute(kill -9 {3})+abort'

    command ps -e -o $format --sort=+pid |
        fzf --multi --no-sort --header-lines 1 --prompt 'kill> ' --delimiter '\s+' \
            --preview 'cat /proc/{3}/status' \
            --bind (string join ',' $binds)
end
