#
# ssh configuration and helpers
#

if status is-interactive
    if command -q ssh-askpass
        set -gx SSH_ASKPASS_REQUIRE prefer
        set -gx SSH_ASKPASS (command -s ssh-askpass)
        set -gx GIT_ASKPASS $SSH_ASKPASS
    end

    if command -q keychain
        SHELL=(command -s fish) keychain --eval --quiet --quick \
            --attempts 3 --agents ssh \
            --absolute --dir $HOME/.local/state/keychain \
            $HOME/.ssh/*.key | source
    end
end
