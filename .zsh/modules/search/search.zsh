#
# Search utility settings, aliases, etc
#

# grep
alias grep='grep --color=auto'

# ripgrep
export RIPGREP_CONFIG_PATH=$HOME/.config/ripgrep

# fzf
if (( $+commands[fzf] )); then
  export FZF_DEFAULT_COMMAND='fd --type file --color=always --follow --hidden --exclude .git'
  export FZF_DEFAULT_OPTS='--height 40%'
fi
