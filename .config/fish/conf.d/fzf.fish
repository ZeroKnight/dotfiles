#
# fzf configuration
#

command -q fzf; or return

set -gx FZF_DEFAULT_OPTS --ansi --highlight-line --info=inline-right

# Use fd as a finder when available
if command -q fd
    set -l common_opts --follow --hidden --exclude .git
    set -gx FZF_DEFAULT_COMMAND fd --type f $common_opts
    # BUG: The special "$dir" handling seems broken on fzf v0.67
    # set -gx FZF_CTRL_T_COMMAND fd --type f --type d $common_opts --search-path \$dir
    # set -gx FZF_ALT_C_COMMAND fd --type d $common_opts --search-path \$dir

    set -gx FZF_ALT_C_OPTS --preview "'tree -C {}'"
    # NOTE: _fzf_compgen_* is not used with fish
else
    set -gx FZF_DEFAULT_COMMAND find -type f -L
end

# Trying out fish's Ctrl+R for now
set -gx FZF_CTRL_R_COMMAND

if command -q bat
    set -gx FZF_CTRL_T_OPTS --preview "'bat -n --color=always {} 2>/dev/null || tree -C {}'"
end

# Extract Tokyonight color definitions because I don't like that it sets
# options other than --color.
set -l tokyonight_extras $HOME/.local/opt/tokyonight-extras/extras
if test -d $tokyonight_extras && set -q tokyonight_variant
    set -a FZF_DEFAULT_OPTS --color=(
        awk '/--color=/ { sub("--color=", ""); print $1 }' $tokyonight_extras/fzf/tokyonight_$tokyonight_variant.sh |
        string join ','
    )
end

# Shell integration
fzf --fish | source

# Don't replace shift-tab search
bind -e shift-tab
bind -M insert -e shift-tab
