#
# A z implementation in Lua
#

export ZLUA_SCRIPT="$HOME/.local/opt/zlua/z.lua"
export ZLUA_LUAEXE="${commands[luajit]:-$commands[lua]}"

export _ZL_DATA="${XDG_DATA_HOME:-"$HOME/.local/share/zlua"}"
export _ZL_NO_PROMPT_COMMAND=1
export _ZL_EXCLUDE_DIRS='/tmp'
export _ZL_MATCH_MODE=1  # Use enhanced matching
export _ZL_FZF_FLAG="+s -0 -1 --prompt 'z.lua > ' --preview 'exa --oneline --icons --group-directories-first {2}'"


if ! [[ -e "$ZLUA_SCRIPT" && -n "$ZLUA_LUAEXE" ]]; then
  return
fi

autoload -Uz add-zsh-hook
add-zsh-hook precmd _zlua_precmd

[[ -d ${_ZL_DATA:h} ]] || mkdir -p ${_ZL_DATA:h}

alias z='zlua'
alias zb='z -b'  # Restrict to parents of CWD
alias zz='z -c'  # Restrict to subdirectories of CWD

# Select interactively
if (( $+commands[fzf] )); then
  alias zi='z -I'
else
  alias zi='z -i'
fi
alias zbi='zi -b'
alias zzi='zi -c'
