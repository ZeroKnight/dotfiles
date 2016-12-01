#
# Default sessions and their layouts
#

new-session -d -c $HOME -s main
new-window -d -n ssh-dz 'autossh -M 0 dz'

new-session -d -c $HOME -s irc weechat

# vim: ft=tmux
