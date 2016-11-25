#
# Input settings and keybinds
#

# Explicitly load complist to ensure menu-select can be re-defined by compinit
# and that the `listscroll` and `menuselect` keymaps are available
zmodload zsh/complist

# Human-friendly key names
zmodload zsh/terminfo
typeset -gA zsh_key_info
zsh_key_info=(
  'Control'      '\C-'
  'ControlLeft'  '\e[1;5D \e[5D \e\e[D \eOd \eOD'
  'ControlRight' '\e[1;5C \e[5C \e\e[C \eOc \eOC'
  'Escape'       '\e'
  'Meta'         '\M-'
  'Backspace'    "^?"
  'Delete'       "^[[3~"
  'F1'           "${terminfo[kf1]}"
  'F2'           "${terminfo[kf2]}"
  'F3'           "${terminfo[kf3]}"
  'F4'           "${terminfo[kf4]}"
  'F5'           "${terminfo[kf5]}"
  'F6'           "${terminfo[kf6]}"
  'F7'           "${terminfo[kf7]}"
  'F8'           "${terminfo[kf8]}"
  'F9'           "${terminfo[kf9]}"
  'F10'          "${terminfo[kf10]}"
  'F11'          "${terminfo[kf11]}"
  'F12'          "${terminfo[kf12]}"
  'Insert'       "${terminfo[kich1]}"
  'Home'         "${terminfo[khome]}"
  'PageUp'       "${terminfo[kpp]}"
  'End'          "${terminfo[kend]}"
  'PageDown'     "${terminfo[knp]}"
  'Up'           "${terminfo[kcuu1]}"
  'Left'         "${terminfo[kcub1]}"
  'Down'         "${terminfo[kcud1]}"
  'Right'        "${terminfo[kcuf1]}"
  'BackTab'      "${terminfo[kcbt]}"
)

# Disable Flow Control
stty -ixon

# Set Vi-keys
bindkey -v

# Some basics
bindkey "$zsh_key_info[Delete]" delete-char
bindkey "$zsh_key_info[Home]" beginning-of-line
bindkey "$zsh_key_info[End]" end-of-line
bindkey '^Z' undo

# Shift+Tab to go backward in menu completion
bindkey "$zsh_key_info[BackTab]" reverse-menu-complete

# Edit command line in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey -a 'q:' edit-command-line

# Buffer stack
bindkey '^Q' push-line-or-edit
bindkey -a '^Q' push-line-or-edit

# Automatic History Expansion
#bindkey ' ' magic-space

# Enable Prediction
autoload -U predict-on
zle -N predict-on
zle -N predict-off
bindkey '^Xp' predict-on
bindkey '^XP' predict-off

# Go straight to menu completion if we hit <Tab> again with list-prompt
listscroll-skip() {
  send-break
  self-insert
}
zle -N listscroll-skip
bindkey -M listscroll '^I' listscroll-skip

# Very elegant trick from Zim
double-dot-expand() {
  if [[ ${LBUFFER} == *.. ]]; then
    LBUFFER+='/..'
  else
    LBUFFER+='.'
  fi
}
zle -N double-dot-expand
bindkey '.' double-dot-expand

# Busy-indicator for completion
complete-word-with-indicator() {
  print -Pn " %{%F{magenta}\u231B%f%}"
  zle complete-word
  zle redisplay
}
zle -N complete-word-with-indicator
bindkey '^I' complete-word-with-indicator

# Smart URL Pasting and escaping
autoload -Uz is-at-least
if [[ $ZSH_VERSION != 5.1.1 ]]; then
  if is-at-least 5.2; then
    autoload -Uz bracketed-paste-url-magic
    zle -N bracketed-paste bracketed-paste-url-magic
  else
    if is-at-least 5.1; then
      autoload -Uz bracketed-paste-magic
      zle -N bracketed-paste bracketed-paste-magic
    fi
    autoload -Uz url-quote-magic
    zle -N self-insert url-quote-magic
  fi
fi

### Options

# Perform a path search even on command names with slashes in them.
# Ex: path=(... /usr/local/bin); X11/xinit ~> /usr/local/bin/X11/xinit
setopt path_dirs

