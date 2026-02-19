#
# ssh configuration and helpers
#

if status is-interactive
    if command -q keychain
        keychain --eval --quiet --quick \
            --attempts 3 --agents ssh \
            --absolute --dir $HOME/.local/state/keychain \
            $HOME/.ssh/*.key | source
    end

    if command -q ssh-askpass
        set -gx SSH_ASKPASS (command -s ssh-askpass)
    end
end
