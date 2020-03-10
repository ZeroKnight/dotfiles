#
# Fasd Configuration
#

(( $+commands[fasd] )) || return 1

export _FASD_DATA="${XDG_DATA_HOME:-"$HOME/.local/share"}/fasd"
_fasd_cache="${XDG_CACHE_HOME:-"$HOME/.cache"}/fasd/init"
_fasd_hooks="$(print zsh-{c,w}comp{,-install})"

### Initialize fasd

# Need to explicitly export since we've separated the _fasd_preexec definition
# from fasd's usual init process. fasd doesn't export its variables, so when
# _fasd_preexec runs, $_FASD_SINK will be null and cause the redirection to
# error out.
export _FASD_SINK="${XDG_CACHE_HOME:-"$HOME/.cache"}/fasd/fasd.log"

# fasd inefficiently tries various versions of awk before falling back to `awk`
# by attempting to run a fixed list of awk versions, stopping when one works;
# this unnecessarily pollutes _FASD_SINK. We'll do things properly and check
# for the existence of a particular version first, and set _FASD_AWK to avoid
# fasd's awk loop altogether.
export _FASD_AWK="${commands[(r)*awk*]}"

for dir ($_FASD_SINK $_FASD_DATA $_fasd_cache) {
  [[ -d ${dir:h} ]] || mkdir -p ${dir:h}
}

# Cache initialization code if needed
if [[ "$commands[fasd]" -nt "$_fasd_cache" || ! -s "$_fasd_cache" ]]; then
  fasd --init ${=_fasd_hooks} >| $_fasd_cache
  zcompile $_fasd_cache
fi
source "$_fasd_cache"
unset _fasd_{cache,hooks}

autoload -Uz add-zsh-hook
add-zsh-hook preexec _fasd_preexec

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

