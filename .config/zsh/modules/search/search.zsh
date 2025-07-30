#
# Search utility settings, aliases, etc
#

# grep
alias grep='grep --color=auto'

# ripgrep
export RIPGREP_CONFIG_PATH=$HOME/.config/ripgrep

# fzf
if (( $+commands[fzf] )); then
  if (( $+commands[fd] )); then
    export FZF_DEFAULT_COMMAND='fd --type file --color=auto --follow --hidden --exclude .git'
    _fzf_compgen_path() {
        fd --hidden --follow --exclude '.git' . "$1"
    }
    _fzf_compgen_dir() {
        fd --type dir --hidden --follow --exclude '.git' . "$1"
    }
  else
    export FZF_DEFAULT_COMMAND='find -type f -L'
  fi
  export FZF_DEFAULT_OPTS='--ansi --height 40%'
  autoload -U +X _fzf_comprun
fi
