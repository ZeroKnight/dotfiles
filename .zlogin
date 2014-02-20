#   _____                   __ __       _       __    __ _
#  /__  /  ___  _________  / //_/____  (_)___ _/ /_  / /( )_____
#    / /  / _ \/ ___/ __ \/ ,<  / __ \/ / __ `/ __ \/ __/// ___/
#   / /__/  __/ /  / /_/ / /| |/ / / / / /_/ / / / / /_  (__  )
#  /____/\___/_/   \____/_/ |_/_/ /_/_/\__, /_/ /_/\__/ /____/
#                                     /____/
#                         __            _
#                  ____  / /___  ____ _(_)___
#                 /_  / / / __ \/ __ `/ / __ \
#                _ / /_/ / /_/ / /_/ / / / / /
#               (_)___/_/\____/\__, /_/_/ /_/
#                             /____/

# Start tmux
if isAvailable tmux &&
  [[ "$TERM" != screen* ]] &&
  [ -z "$TMUX" ]; then
    exec tmux new-session -A -s main -n $HOSTNAME
fi

# Display a lovely fortune
isAvailableRun fortune

# Start keychain
if [ -z "$SSH" ] && isAvailable keychain; then
    eval $(keychain --eval --agents ssh -Q $(ls ~/.ssh/*.key))
fi

