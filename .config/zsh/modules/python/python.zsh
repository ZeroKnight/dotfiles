#
# Python settings and aliases et al
#

# venv directory names for auto-detection
typeset -gT _PYTHON_VENV_NAMES python_venv_names=(venv .venv)

autoload -Uz add-zsh-hook
add-zsh-hook chpwd chpwd_python_venv

# Prefer python3, even on systems that default to 2.7
alias python='python3'
alias py='python'
alias pip='pip3'
alias pydoc='pydoc3'

alias ipy='ipython'
alias pdb='python -m pdb'

if (( $+commands[virtualenv] )); then
    alias venv='virtualenv'
else
    alias venv='python3 -m venv venv'
fi
