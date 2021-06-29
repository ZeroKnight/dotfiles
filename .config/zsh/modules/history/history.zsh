#
# Command history configuration
#

HISTFILE="$ZDATADIR/zhistory"

# HISTFILE should be larger than HISTSAVE to provide a buffer for
# HIST_EXPIRE_DUPS_FIRST
HISTSIZE=10100
SAVEHIST=10000

setopt append_history
setopt extended_history
setopt hist_ignore_dups
setopt hist_expire_dups_first
setopt hist_find_no_dups
setopt hist_ignore_space
setopt hist_no_store # Do not add `fc` commands to history
setopt hist_reduce_blanks
setopt inc_append_history
setopt share_history

#setopt hist_verify

# Beeps are evil
unsetopt hist_beep

### Aliases

# List last 15 events with time-date stamps
alias recent='fc -lf -15'

# List full history
alias hist='fc -lf 1'
alias rhist='fc -lfr 1'

