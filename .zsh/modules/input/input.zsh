#
# Input settings and keybinds
#

# Set Vi-keys
bindkey -v

# Very elegant trick from Zim
double-dot-expand() {
  if [[ ${LBUFFER} == *.. ]]; then
    LBUFFER+='/..'
  else
    LBUFFER+='.'
  fi
}
zle -N double-dot-expand
bindkey "." double-dot-expand

### Options

# Perform a path search even on command names with slashes in them.
# Ex: path=(... /usr/local/bin); X11/xinit ~> /usr/local/bin/X11/xinit
setopt path_dirs

