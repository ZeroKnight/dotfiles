#
# Syntax Highlighting in Zsh
#
# This needs to be one of the last modules loaded so that all zle widgets can
# be handled

# Don't compile z-sy-h unit tests. It's unnecessary, and one test defines an ls
# function that will conflict with our ls alias.
ZCOMPILE_IGNORE_PATTERNS+=('external/**test*')

### Highlighter Settings

# Highlighters to enable
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets cursor)

typeset -A ZSH_HIGHLIGHT_STYLES

# Main
ZSH_HIGHLIGHT_STYLES[path]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=blue'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=blue'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=red'
ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]='fg=red'
ZSH_HIGHLIGHT_STYLES[assign]='fg=cyan,bold'

source "${0:h}/external/zsh-syntax-highlighting.zsh" || return 1

