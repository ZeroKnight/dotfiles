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

### Initialize zcomet

zstyle ':zcomet:*' home-dir $ZCOMET
zstyle ':zcomet:compinit' dump-file "$ZCACHEDIR/zcompdump"
source "$ZCOMET/bin/zcomet.zsh"

# Local configuration
zcomet load $ZDATADIR/site

# Configuration modules
zmodules=(archive directory ssh z git history misc perl python processes \
          spectrum system tmux vim man search input syntax-highlighting)

# NOTE: 'prompt' and 'completion' should ALWAYS be loaded LAST to ensure that
# all module functions/keywords are available to compinit and for the prompt
# to make use of
zmodules+=(prompt completion)

for module ($zmodules) {
    zcomet load $ZDOTDIR/modules/$module
}
unset $module

# NOTE: Load these last
zcomet load zsh-users/zsh-syntax-highlighting
zcomet load zsh-users/zsh-autosuggestions
zcomet load zsh-users/zsh-completions

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
