function fproc --description 'fzf processes to switch to its /proc directory'
    set -f format 'euser:12,ruser:12,pid,ppid,ni,stat=STATE,tty=TTY,lstart,time=CPU_TIME,cmd=COMMAND'

    set -f proc (command ps -e -o $format --sort=+pid |
        fzf --no-sort --header-lines 1 --prompt 'inspect> ' --delimiter '\s+' \
            --query="$argv" --preview 'cat /proc/{3}/status' --accept-nth 3)

    test -n "$proc"; and cd "/proc/$proc"
end
