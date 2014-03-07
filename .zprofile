#   _____                   __ __       _       __    __ _
#  /__  /  ___  _________  / //_/____  (_)___ _/ /_  / /( )_____
#    / /  / _ \/ ___/ __ \/ ,<  / __ \/ / __ `/ __ \/ __/// ___/
#   / /__/  __/ /  / /_/ / /| |/ / / / / /_/ / / / / /_  (__  )
#  /____/\___/_/   \____/_/ |_/_/ /_/_/\__, /_/ /_/\__/ /____/
#                                     /____/
#                                        _____ __
#                ____  ____  _________  / __(_) /__
#               /_  / / __ \/ ___/ __ \/ /_/ / / _ \
#              _ / /_/ /_/ / /  / /_/ / __/ / /  __/
#             (_)___/ .___/_/   \____/_/ /_/_/\___/
#                  /_/

########
### Preliminary Setup & Helpers
############

# Are we on a remote connection?
if [ -n "$SSH_CONNECTION" ] ||
  [ -n "$SSH_CLIENT" ] ||
  [ -n "$SSH_TTY" ]; then
    export SSH='0'
fi

# Do we have this program?
isAvailable() {
    whence -p $1 &>/dev/null
}

isAvailableRun() {
    whence -p $1 &>/dev/null && $1
}


########
### Environment Settings
############

# Set PATH
if [ -d "$HOME/scripts/shell" ]; then
    # Might deprecate this and just use ~/bin
    PATH="$PATH:$HOME/scripts/shell"
fi

if [ -d "$HOME/bin" ]; then
    # *Always* do this *last*
    PATH="$PATH:$HOME/bin"
fi
export PATH

# Set EDITOR
if [ -n "$SSH" ]; then
    export EDITOR='vim'
else
    export EDITOR='gvim'
fi

# `less` Settings
export PAGER='less'
export LESS='-R'
