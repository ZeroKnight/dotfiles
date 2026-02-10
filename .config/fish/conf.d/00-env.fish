#
# Environment variables
#

# One-time set universal variables
if not set -q __zero_env_set_universal
    set -U tokyonight_variant storm

    fish_add_path --universal $HOME/.local/bin
    set -Ux CDPATH $HOME/Projects $HOME/dotfiles
    set -Ux BROWSER firefox

    set -U __zero_env_set_universal true
end

# Some systems exclude sbin from non-root accounts and that harms
# discoverability in completion et al.
fish_add_path --path /usr/{local,}/sbin

if command -q nvim
    set -gx VISUAL nvim
else if command -q vim
    set -gx VISUAL vim
end
set -gx EDITOR $VISUAL
set -g vim_flavor $VISUAL

set -gx PAGER less
set -gx LESS -iMRS

command -q waterfox; and set -gx BROWSER waterfox
