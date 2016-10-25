#
# Fasd Configuration
#

(( $+commands[fasd] )) || return 1

# _fasd_config="${XDG_CONFIG_HOME:-"$HOME/.config"}/fasd/config"
export _FASD_DATA="${XDG_CACHE_HOME:-"$HOME/.cache"}/fasd/fasd"
_fasd_cache="${XDG_CACHE_HOME:-"$HOME/.cache"}/fasd/init"
_fasd_hooks="$(print zsh-{c,w}comp{,-install})"

### Initialize fasd

for dir ($_FASD_DATA $_fasd_cache) {
  [[ -d ${dir:h} ]] || mkdir -p ${dir:h}
}

# Cache initialization code if needed
if [[ "$commands[fasd]" -nt "$_fasd_cache" || ! -s "$_fasd_cache" ]]; then
  fasd --init ${=_fasd_hooks} >| $_fasd_cache
  zcompile $_fasd_cache
fi
source "$_fasd_cache"
unset _fasd_{cache,hooks}

### Aliases

# Standard
alias a='fasd -a'
alias s='fasd -si'
alias sd='fasd -sid'
alias sf='fasd -sif'
alias d='fasd -d'
alias f='fasd -f'
alias z='fasd_cd -d'
alias zz='fasd_cd -d -i'

# Extra
alias v='f -e $EDITOR'

