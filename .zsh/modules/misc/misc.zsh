#
# Everything else
#

### Aliases

alias zopts='set -o | grep --color=always'

# Enable colors
alias diff='diff --color=always'

# Quick Screenshot
alias screenshot='maim -s "$HOME/Pictures/Screenshots/SCREENSHOT_$(date "+%F_%T").png"'
alias screenshotf='maim "$HOME/Pictures/Screenshots/SCREENSHOT_$(date "+%F_%T").png"'

alias rsync='rsync -h'

### Misc zsh options

# BELL BEEPS ARE EVIL. DIE.
setopt no_beep no_list_beep

### Everything else

# Quick-reference for zsh builtins
autoload -Uz run-help
(( $+aliases[run-help] )) && unalias run-help
alias zhelp='run-help'

