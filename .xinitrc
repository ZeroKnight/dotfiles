#!/bin/sh
#
# ~/.xinitrc - Executed by `startx`
#

# Execute system-wide X settings
if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# Load our X resources
[[ -f ~/.config/.Xresources ]] && xrdb -merge -I$HOME/.config/.Xresources.d ~/.config/.Xresources

# Bind various keys
xbindkeys

# Set up and start fcitx (mozc)
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
fcitx

# Start up some staple programs
#xscreensaver -nosplash &
clipit &
pnmixer &
keepass &
guake &

# Start up our WM
exec awesome

