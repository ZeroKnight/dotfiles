#
# systemd aliases and shortcuts
#

abbr -a -r 'sc(tl)?' sctl systemctl
abbr -a -r 'jc(tl)?' jctl journalctl
abbr -a -r 'sc(tl)?u' sctlu -- systemctl --user
abbr -a -r 'jc(tl)?u' jctlu -- journalctl --user

abbr -a -c systemctl st status
abbr -a -c systemctl sr start
abbr -a -c systemctl rs restart
abbr -a -c systemctl sp stop
