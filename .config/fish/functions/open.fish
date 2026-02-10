function open --description 'Open file in default application (detached from terminal)'
    for prog in $argv
        setsid nohup xdg-open $prog &>/dev/null
    end
end
