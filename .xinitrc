#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi
xinput --set-prop 10 "Device Accel Profile" -1 &
xinput --set-prop 9 'Device Accel Constant Deceleration' 1 &
while true; do xsetroot -name "$(date)";sleep 1s; done &
exec dwm
# exec gnome-session
# exec startkde
# exec startxfce4
# ...or the Window Manager of your choice
