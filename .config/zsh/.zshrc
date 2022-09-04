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

# Set up PATHs
path=(
  ~/.local/bin
  $path
)

fpath=(
  $ZDOTDIR/modules/*/functions
  $fpath
)

cdpath=(
  $ZDOTDIR
)

# Modules
zmodules=(archive directory ssh z git history misc perl python processes \
          spectrum system tmux vim man search input syntax-highlighting)

# Local configuration
if [[ -d "$ZDATADIR/site" ]]; then
  for script ($ZDATADIR/site/*.zsh(N)) {
    source $script
  }
  unset script
fi

# NOTE: 'prompt' and 'completion' should ALWAYS be loaded LAST to ensure that
# all module functions/keywords are available to compinit and for the prompt
# to make use of
zmodules+=(prompt completion)

typeset -a ZCOMPILE_IGNORE_PATTERNS
for module ($zmodules) {
  mpath="$ZDOTDIR/modules/$module"

  # Load configuration files
  if [[ -s "$mpath/$module.zsh" ]]; then
    source "$mpath/$module.zsh"
  else
    print "** Module '$module' not found!"
  fi

  # Autoload functions
  [[ -d "$mpath/functions" ]] || continue
  function {
    setopt LOCAL_OPTIONS EXTENDED_GLOB NULL_GLOB
    local funcs=( $(print $mpath/functions/^[._]*~*.zwc(-.:t)) )
    (( $#funcs )) && autoload -Uz $funcs
  }
}
unset module mpath

### Compile configuration files in the background

(
  setopt EXTENDED_GLOB NULL_GLOB

  # zcompile the completion cache; siginificant speedup.
  for f ($ZCACHEDIR/zcomp^(*.zwc)(.)) zcompare $f

  # zcompile .zshrc
  zcompare $ZDOTDIR/.zshrc

  # zcompile all module config files
  for ((i = 1; i <= $#ZCOMPILE_IGNORE_PATTERNS; ++i)) {
    pattern=$ZCOMPILE_IGNORE_PATTERNS[i]
    ZCOMPILE_IGNORE_PATTERNS[i]="~*$pattern"
  }
  for cfg ($ZDOTDIR/modules/**/*.zsh${(j::)~ZCOMPILE_IGNORE_PATTERNS}(.)) {
    # Only attempt to compile enabled modules
    if (( $zmodules[(Ie)$cfg:h:t] )); then
      zcompare $cfg
    fi
  }
  for cfg ($ZDATADIR/site/*.zsh)
    zcompare $cfg

  # zcompile all autoloaded functions
  for func ($ZDOTDIR/modules/*/functions/^(*.zwc)(.)) {
    # Only attempt to compile enabled modules
    if (( $zmodules[(Ie)$func:h:h:t] )); then
      zcompare $func
    fi
  }
) &!

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
