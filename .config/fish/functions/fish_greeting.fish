function fish_greeting
    if set -q fish_private_mode
        echo (set_color magenta) 'fish is running in private mode, history will not be persisted.' (set_color reset)
    end
end
