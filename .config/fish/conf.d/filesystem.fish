#
# Filesystem browsing, querying, directory navigation, file management, etc.
#

# Erase embedded ls functions
functions -e ls ll la

if status is-interactive
    # Human readable defaults when interactive
    alias df 'df -h'
    alias du 'du -h'

    alias md 'mkdir -vp'
    abbr -a rd rmdir

    if command -q eza
        set -g __zero_eza_opts '--icons --hyperlink --group --group-directories-first'
        set -gx EZA_ICON_SPACING 2 # Accomodate kitty
        alias eza "eza $__zero_eza_opts"
        alias ls eza
    else
        set -g __zero_ls_opts '-hFH --color=auto --hyperlink=auto --group-directories-first'
        alias ls "ls $__zero_ls_opts"
    end
    abbr -a sl ls # Doh
    abbr -a ll ls -l
end
