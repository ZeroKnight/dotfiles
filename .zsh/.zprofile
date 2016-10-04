#
# ZeroKnight's .zprofile
#

### Set up paths
typeset -gU path fpath cdpath

path=(
  ~/bin
  $path
)

fpath=(
  $ZDOTDIR/modules/*/functions
  $fpath
)

cdpath=(
  $ZDOTDIR
)

