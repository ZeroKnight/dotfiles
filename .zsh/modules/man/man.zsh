#
# Manpage viewer settings
#

# Use Neovim as our manpager
if (( $+commands[nvim] )); then
  export MANPAGER="nvim -c 'set ft=man' -"
else
  export MANPAGER='env MAN_PN=1 vim -M +MANPAGER -'
fi

