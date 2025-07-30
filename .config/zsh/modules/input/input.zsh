#
# Input settings and keybinds
#

zmodload zsh/terminfo
zmodload zsh/pcre

# Explicitly load complist to ensure menu-select can be re-defined by compinit
# and that the `listscroll` and `menuselect` keymaps are available
zmodload zsh/complist

# Load zkbd file for the current TERM, if available
[[ -f "$ZDOTDIR/.zkbd/$TERM" ]] && source "$ZDOTDIR/.zkbd/$TERM" || typeset -gA key

# Fall back on terminfo, then a reasonable default if not set by zkbd
key[F1]="${key[F1]:-${terminfo[kf1]:-\eOP}}"
key[F2]="${key[F2]:-${terminfo[kf2]:-\eOQ}}"
key[F3]="${key[F3]:-${terminfo[kf3]:-\eOR}}"
key[F4]="${key[F4]:-${terminfo[kf4]:-\eOS}}"
key[F5]="${key[F5]:-${terminfo[kf5]:-\e[15~}}"
key[F6]="${key[F6]:-${terminfo[kf6]:-\e[17~}}"
key[F7]="${key[F7]:-${terminfo[kf7]:-\e[18~}}"
key[F8]="${key[F8]:-${terminfo[kf8]:-\e[19~}}"
key[F9]="${key[F9]:-${terminfo[kf9]:-\e[20~}}"
key[F10]="${key[F10]:-${terminfo[kF10]:-\e[21~}}"
key[F11]="${key[F11]:-${terminfo[kF11]:-\e[23~}}"
key[F12]="${key[F12]:-${terminfo[kF12]:-\e[24~}}"
key[Backspace]="${key[Backspace]:-${terminfo[kbs]:-^?}}"
key[Insert]="${key[Insert]:-${terminfo[kich1]:-\e[2~}}"
key[Home]="${key[Home]:-${terminfo[khome]:-\e[H}}"
key[PageUp]="${key[PageUp]:-${terminfo[kpp]:-\e[5~}}"
key[Delete]="${key[Delete]:-${terminfo[kdch1]:-\e[3~}}"
key[End]="${key[End]:-${terminfo[kend]:-\e[F}}"
key[PageDown]="${key[PageDown]:-${terminfo[knp]:-\e[6~}}"
key[Up]="${key[Up]:-${terminfo[kup]:-\e[A}}"
key[Left]="${key[Left]:-${terminfo[kLeFt]:-\e[D}}"
key[Down]="${key[Down]:-${terminfo[kDoWn]:-\e[B}}"
key[Right]="${key[Right]:-${terminfo[kRigHt]:-\e[C}}"
key[Menu]="${key[Menu]:-\e[29~}"
key[BackTab]="${key[BackTab]:-${terminfo[kcbt]:-\e[Z}}"

# Shortcuts
key[ControlLeft]='\e[1;5D'
key[ControlRight]='\e[1;5C'

# Disable Flow Control
stty -ixon

# Set Vi-keys
bindkey -v

# Basics
bindkey '^Z' undo
bindkey -a Y vi-yank-eol

# Movement
bindkey "$key[Delete]" delete-char
bindkey "$key[Home]" beginning-of-line
bindkey "$key[End]" end-of-line
bindkey "$key[ControlLeft]" backward-word
bindkey "$key[ControlRight]" forward-word

# Avoid annoying vi-behavior of not going past the start of insertion
bindkey "$key[Backspace]" backward-delete-char
bindkey -a "X" backward-delete-char
bindkey '^W' backward-kill-word
bindkey '^U' backward-kill-line

# Include some emacs/readline style binds
bindkey '^K' kill-line

# Shift+Tab to go backward in menu completion
bindkey "$key[BackTab]" reverse-menu-complete

# Edit command line in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey -a 'q:' edit-command-line

# Buffer stack
bindkey '^Q' push-line-or-edit
bindkey -a '^Q' push-line-or-edit

# Automatic History Expansion
bindkey ' ' magic-space

# Wrap line in quotes
bindkey "\e'" quote-line

# Alt+Enter: Execute command and automatically add it back to the buffer
# Easily build off of the last command; useful when combing directories.
bindkey '\e^M' accept-and-hold

# Enable quickly re-running a sequence of commands
bindkey '\C-n' accept-and-infer-next-history

### Advanced/Custom Widgets

# Go straight to menu completion if we hit <Tab> again with list-prompt
listscroll-skip() {
  send-break
  self-insert
}
zle -N listscroll-skip
bindkey -M listscroll '^I' listscroll-skip

# Busy-indicator for completion
complete-word-with-indicator() {
  print -Pn " %{%F{magenta}\u231B%f%}"
  zle complete-word
  zle redisplay
}
zle -N complete-word-with-indicator

if (( $+commands[fzf] )); then
  fzf_default_completion='complete-word-with-indicator'
else
  bindkey '^I' complete-word-with-indicator
fi

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

# Change cursor based on insert/normal mode
zle-line-init zle-keymap-select() {
    case $KEYMAP {
        vicmd) printf '\e[1 q' ;;
        viins|main) printf '\e[5 q' ;;
    }
}
zle -N zle-line-init
zle -N zle-keymap-select

# Prepend 'sudo' to current cmdline
zle-prepend-sudo() {
    LBUFFER="sudo $LBUFFER"
    zle redisplay
}
zle -N zle-prepend-sudo
bindkey '^S' zle-prepend-sudo

### Options

# Perform a path search even on command names with slashes in them.
# Ex: path=(... /usr/local/bin); X11/xinit ~> /usr/local/bin/X11/xinit
setopt path_dirs

### fzf keybinds
(( $+commands[fzf] )) && source "${commands[fzf]:h:h}/share/fzf/shell/key-bindings.zsh"
