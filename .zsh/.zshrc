#
# ZeroKnight's .zshrc
#

### Utility functions

# zcompiles a file if there is no .zwc file, or the base file is newer than
# the existing .zwc file.
zcompare() {
  if [[ -s $1 && (! -s ${1}.zwc || $1 -nt ${1}.zwc) ]]; then
    zcompile $1
  fi
}

### Initialize zsh

# Load configuration files
for module ($ZDOTDIR/modules/*(N)) {
  [[ -s "$module/${module:t}.zsh" ]] && source "$module/${module:t}.zsh"
}

# Autoload functions
function {
  setopt LOCAL_OPTIONS EXTENDED_GLOB
  for func ($ZDOTDIR/modules/*/functions/^[._]*~*.zwc(-.N:t)) {
    autoload -Uz $func
  }
}
unset module func

### Run core programs

# Display a lovely fortune (but only if stdout is connected to a terminal)
if (( $+commands[fortune] )) && [[ -t 1 ]]; then
  fortune
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

