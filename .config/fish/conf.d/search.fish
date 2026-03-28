#
# Search utility settings, aliases, etc
#

alias grep 'grep --color=auto'

set -gx RIPGREP_CONFIG_PATH $XDG_CONFIG_HOME/ripgrep
abbr -a rgd --set-cursor 'rg --json % | delta'
