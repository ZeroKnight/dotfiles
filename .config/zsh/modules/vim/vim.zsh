#
# Miscellaneous (n)vim related things
#

if (( $+commands[nvim] )); then
  export VIM_FLAVOR="$commands[nvim]"
else
  export VIM_FLAVOR="$commands[vim]"
fi

alias :h='vhelp'
