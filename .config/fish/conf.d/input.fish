#
# Keybinds
#

# NOTE: The `default` mode is vi-mode's "Normal" mode

function fish_zeroknight_key_bindings --description 'My personalized take on hybrid bindings'
    # Enable readline/emacs-like keybinds in insert/replace mode
    for mode in insert replace
        fish_default_key_bindings -M $mode
    end
    fish_vi_key_bindings --no-erase insert

    # Modify or remove some preset binds
    bind --preset -M insert ctrl-n down-or-search
end

function fish_user_key_bindings
    # Zsh-like buffer stack
    for mode in default insert replace
        bind -M $mode -m insert ctrl-q push-command-line
    end
end

set -g fish_key_bindings fish_zeroknight_key_bindings
