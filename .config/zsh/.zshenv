#
# ZeroKnight's .zshenv
#

# Declare *PATH variables
# NOTE: Do NOT assign to PATH here. It will likely be overwritten by
# /etc/profile
typeset -gxU PATH FPATH CDPATH path fpath cdpath

# Enable 256 Colors. Only export outside of a tmux session so we don't trample
# over the TERM value that tmux sets. In addition, only export if we're not
# using kitty.
if (( ! $+TMUX )) && [[ $TERM != 'xterm-kitty' ]]; then
  export TERM='xterm-256color'
fi

# Keep our zsh files nice and tidy in their own directories
export ZDOTDIR="${XDG_CONFIG_HOME:-"$HOME/.config"}/zsh"
export ZSH="$ZDOTDIR"
export ZDATADIR="${XDG_DATA_HOME:-"$HOME/.local/share"}/zsh"
export ZSTATEDIR="${XDG_STATE_HOME:-"$HOME/.local/state"}/zsh"
export ZCACHEDIR="${XDG_CACHE_HOME:-"$HOME/.cache"}/zsh"

for dir in "$ZDOTDIR" "$ZDATADIR" "$ZCACHEDIR" "$ZSTATEDIR"; do
    [[ -d "$dir" ]] || mkdir -p "$dir"
done

export ZCOMET="$HOME/.local/opt/zcomet"

# Can add module names to this array to prevent loading them. Most likely
# would be added in a site config file.
typeset -axgU ZSH_DISABLED_MODULES

# Are we on a remote connection?
if (( $+SSH_CONNECTION || $+SSH_CLIENT || $+SSH_TTY )); then
    export SSH='1'
fi

# Set program-related environment variables
if (( $+commands[nvim] )); then
  export VISUAL='nvim'
else
  export VISUAL='vim'
fi
export EDITOR="$VISUAL"
export PAGER='less' LESS='-iMRS'
if (( $+DISPLAY )); then
    export BROWSER='firefox'
    export XIVIEWER='sxiv'
else
    export BROWSER="${commands[(lynx|elinks|links|w3m)]}"
fi

# Disable global compinit on systems like Ubuntu
typeset -g skip_global_compinit=1
