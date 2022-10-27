#
# zsh-history-substring-search
#

typeset -g HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=magenta,fg=black,bold'
typeset -g HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bg=red,fg=black,bold'

bindkey $key[Up] history-substring-search-up
bindkey $key[Down] history-substring-search-down
