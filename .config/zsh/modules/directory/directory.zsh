#
# Directory settings, aliases and functions
#

autoload -Uz z{mv,cp,ln}

### dircolors

# Set LS_COLORS
[[ -e $HOME/.config/.dircolors ]] && eval $(dircolors -b $HOME/.config/.dircolors)

# Enable dircolors in file completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

### Zsh options

# Automatic directory stack management
setopt auto_pushd pushd_ignore_dups pushdminus

# cd Modifications
setopt auto_cd # `foo` == `[-d 'foo'] && cd foo`
setopt cdable_vars

# Make named directories available immediately
setopt auto_name_dirs
: ~ZSH ~ZDATADIR ~ZCACHEDIR # Make available despite being set before this option

NVIMC="$HOME/.config/nvim"
NVIMD="$HOME/.local/share/nvim"

### Aliases

# Directory Aliases
alias df='df -h'  # Human-readable
alias du='du -ch' # Human-readable; total
alias md='mkdir -vp'
alias rd='rmdir'

# Directory Stack Shortcuts
alias pu='pushd'
alias po='popd'
alias -- -='cd -'

# Directory Listing
if (( $+commands[eza] )); then
  export EZA_ICON_SPACING=2  # Accommodate kitty

  alias eza='eza --group --icons --group-directories-first --hyperlink'
  alias ls='eza'
else
  alias ls='ls -hFH --color=auto --hyperlink=auto --group-directories-first'
fi

alias ll='ls -l'
alias lr='ls -R'
alias llr='ll -R'

alias lss='ls | less'
alias lls='ll | less'

alias sl='ls' # Doh
