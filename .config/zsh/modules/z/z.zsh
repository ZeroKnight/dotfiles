#
# A z implementation in Lua
#

ZCOMPILE_IGNORE_PATTERNS+=('external/z.lua.plugin.zsh')

export ZLUA_SCRIPT="$ZSH/modules/z/external/z.lua"
export ZLUA_LUAEXE="${commands[luajit]:-$commands[lua]}"

export _ZL_DATA="${XDG_DATA_HOME:-"$HOME/.local/share/zlua"}"
export _ZL_NO_PROMPT_COMMAND=1
export _ZL_EXCLUDE_DIRS='/tmp'
export _ZL_MATCH_MODE=1  # Use enhanced matching

autoload -Uz add-zsh-hook
add-zsh-hook precmd _zlua_precmd

[[ -d ${_ZL_DATA:h} ]] || mkdir -p ${_ZL_DATA:h}

alias z='zlua'
alias zz='z -c'  # Restrict to subdirectories of CWD
alias zu='z -b'  # Restrict to parents of CWD

# Select interactively
if (( $+commands[fzf] )); then
  alias zi='z -I'
else
  zlias zi='z -i'
fi
