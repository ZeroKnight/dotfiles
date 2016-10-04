#
# dircolors
#

# Set LS_COLORS
eval $(dircolors -b $HOME/.config/.dircolors)

# Enable dircolors in file completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

