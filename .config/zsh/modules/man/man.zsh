#
# Manpage viewer settings
#

# Use Neovim as our manpager
if (( $+commands[nvim] )); then
  export MANPAGER="nvim +Man!"
else
  export MANPAGER='env MAN_PN=1 vim -M +MANPAGER -'
fi

