# Configuration for fasd

# Set up the hook
local fasd_cache="$HOME/.cache/.fasd-init-cache"
local fasd_hook='zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install posix-alias posix-hook'

if [ $(command -v fasd) ]; then # check if fasd is installed
    if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
        fasd --init "$fasd_hook" >| "$fasd_cache"
    fi
    source "$fasd_cache"

    # Set aliases
    alias v='f -e vim'
fi

