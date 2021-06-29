#
# Aliases et al for tmux
#

alias t='tmux'
alias ta='tmux attach-session -t'
alias tns='tmux new-session'

# tmuxinator
if (( $+commands[tmuxinator] )); then
  alias mux='tmuxinator'
fi
