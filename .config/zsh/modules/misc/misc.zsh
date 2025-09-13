#
# Everything else
#

### Aliases

alias zopts='set -o | grep --color=auto'

# Enable colors
alias diff='diff --color=auto'
alias ip='ip -color=auto'

# Add some nice defaults to rsync (can disable as needed with --no-<option>)
alias rsync='rsync -hhh --partial --info=stats1,progress2,name1'

### Misc zsh options

# BELL BEEPS ARE EVIL. DIE.
setopt no_beep no_list_beep

### Everything else

# Quick-reference for zsh builtins
autoload -Uz run-help
(( $+aliases[run-help] )) && unalias run-help
alias zhelp='run-help'
