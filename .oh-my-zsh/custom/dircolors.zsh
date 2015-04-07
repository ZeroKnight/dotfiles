eval $(dircolors -b $HOME/.config/.dircolors)

# From:
# https://github.com/robbyrussell/oh-my-zsh/issues/1563#issuecomment-26591369
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
autoload -Uz compinit
compinit -u
