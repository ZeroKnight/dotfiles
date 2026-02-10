function psg --wraps=pgrep --description 'ps + grep without the grep'
    set -f pids (pgrep -d, $argv)
    test -n "$pids"; or return 1
    command ps -p $pids
end
