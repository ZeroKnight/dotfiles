#
# ZeroKnight's .zshrc
#

# Set up PATHs
path=(
    ~/.local/bin
    $path
)

cdpath=(
    $ZDOTDIR
)

localmod() {
    if (( ! $ZSH_DISABLED_MODULES[(Ie)$1] )) {
        zcomet load "$ZDOTDIR/modules/$1"
    }
}

# Initialize zcomet

zstyle ':zcomet:*' home-dir $ZCOMET
zstyle ':zcomet:compinit' dump-file "$ZCACHEDIR/zcompdump"
source "$ZCOMET/bin/zcomet.zsh"

# Local configuration
if [[ -d "$ZDATADIR/site" ]] {
    for script ($ZDATADIR/site/*.zsh(N)) {
        zcomet snippet "$script"
    }
    unset script
}

### Configuration modules

# Zsh Basics
localmod history

# Programs
localmod archive
localmod directory
localmod man
localmod processes
localmod search
localmod ssh
localmod system
localmod tmux
localmod vim

# Language Support and Development
localmod git
localmod go
localmod perl
localmod python

# Tools/Utilities
localmod misc
localmod spectrum
localmod z

# NOTE: Load these last
localmod input
localmod prompt
localmod completion
localmod syntax-highlighting
zcomet load zsh-users/zsh-syntax-highlighting
zcomet load zsh-users/zsh-history-substring-search
zcomet load zsh-users/zsh-autosuggestions
zcomet load zsh-users/zsh-completions

localmod autosuggestions
localmod history-substring-search

zcomet compinit

### Run core programs

# Display a lovely fortune (but only if stdout is connected to a terminal)
if (( $+commands[fortune] )) && [[ -t 1 ]]; then
  fortune -a
  print
fi

# Start keychain
if (( ! $+SSH && $+commands[keychain] )); then
    eval $(keychain \
      --eval \
      --attempts 3 \
      --agents ssh \
      --quick \
      --quiet \
      ~/.ssh/*.key
    )
fi

# Tmuxifier
if (( $+commands[tmuxifier] )); then
    eval "$(tmuxifier init -)"
    export TMUXIFIER_LAYOUT_PATH="$HOME/.config/tmuxifier"
fi
