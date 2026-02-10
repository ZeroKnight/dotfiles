#
# Manpages
#

if status is-interactive
    # Use (Neo)vim as manpager when available
    if command -q nvim
        set -gx MANPAGER nvim +Man!
    else if command -q vim
        set -gx MANPAGER env MAN_PN=1 vim -M +MANPAGER -
    end
end
