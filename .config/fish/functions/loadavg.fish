function loadavg --description 'Print current load averages'
    set ncpu (nproc)
    set loadavg (cat /proc/loadavg | string split ' ')
    echo "System Load: $loadavg[1..3] over $ncpu cores"
end
