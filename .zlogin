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
    # Attach to main session, creating it if it doesn't exist yet
    tmux new-session -A -s main -n $HOSTNAME
    if ! tmux has -t irc; then
        # Create irc session
        tmux new-session -s irc
    fi
fi

# Display a lovely fortune
isAvailableRun fortune

# Start keychain
if [ -z "$SSH" ] && isAvailable keychain; then
    eval $(keychain --eval --agents ssh -Q ~/.ssh/*.key)
fi

