#
# Command history
#

# DIY History Expansion

function history_expand
    switch $argv[1]
        case !!
            echo $history[1]
        case '!$'
            echo (string split ' ' $history[1])[-1]
    end
end

if status is-interactive
    abbr -a !! -p anywhere -f history_expand
    abbr -a '!$' -p anywhere -f history_expand
end
