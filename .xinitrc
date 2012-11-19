#!/bin/sh
#
# ~/.xinitrc for Arch Linux
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

DEFAULT_SESSION=openbox-session

case $1 in
openbox)
    exec openbox-session
    ;;
*)
    exec $DEFAULT_SESSION
    ;;
esac
