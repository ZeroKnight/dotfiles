#   _____                   __ __       _       __    __ _
#  /__  /  ___  _________  / //_/____  (_)___ _/ /_  / /( )_____
#    / /  / _ \/ ___/ __ \/ ,<  / __ \/ / __ `/ __ \/ __/// ___/
#   / /__/  __/ /  / /_/ / /| |/ / / / / /_/ / / / / /_  (__  )
#  /____/\___/_/   \____/_/ |_/_/ /_/_/\__, /_/ /_/\__/ /____/
#                            __       /____/
#                ____  _____/ /_  ___  ____ _   __
#               /_  / / ___/ __ \/ _ \/ __ \ | / /
#              _ / /_(__  ) / / /  __/ / / / |/ /
#             (_)___/____/_/ /_/\___/_/ /_/|___/
#

# Set PATH
# TODO: Deprecate ~/scripts* in favor of ~/bin ?
typeset -U path # Ensure entires in PATH are unique
path=(~/bin ~/scripts/shell $path)

# NOTE: Should the following belong in .zshrc ?

# Set EDITOR, BROWSER
if [ -n "$DISPLAY" ]; then
    export EDITOR='gvim'
    export BROWSER='firefox'
else
    export EDITOR='vim'
    export BROWSER='elinks'
fi

# Are we on a remote connection?
if [ -n "$SSH_CONNECTION" ] ||
  [ -n "$SSH_CLIENT" ] ||
  [ -n "$SSH_TTY" ]; then
    export SSH='0'
fi

