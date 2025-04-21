#
# zsh-autosuggestions
#

typeset -g ZSH_AUTOSUGGEST_STRATEGY=(history completion)

bindkey '^Y' autosuggest-execute
bindkey '^F' autosuggest-accept
