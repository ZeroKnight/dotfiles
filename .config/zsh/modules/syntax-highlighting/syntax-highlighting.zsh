#
# Syntax Highlighting in Zsh
#
# This needs to be one of the last modules loaded so that all zle widgets can
# be handled

# Highlighters to enable
typeset -ga ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

typeset -gA ZSH_HIGHLIGHT_STYLES=(
    [path]='fg=magenta'
    [single-hyphen-option]='fg=blue'
    [double-hyphen-option]='fg=blue'
    [back-quoted-argument]='fg=cyan'
    [back-double-quoted-argument]='fg=red'
    [back-dollar-quoted-argument]='fg=red'
    [assign]='fg=cyan,bold'
)
