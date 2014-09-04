#!/bin/bash

#export DE=openbox

# Dbus fix
#if [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
 # eval "$(dbus-launch --sh-syntax --exit-with-session)"
#fi

#/usr/bin/xdg-user-dirs-update

# start openbox
#/usr/bin/openbox-session > ~/.openbox_startup.log 2>&1
while true 
do
	xsetroot -name  "$(date +"%a %b %d %R")"
	sleep 1s
done &
exec dwm
#feh --bg-scale /home/methos/Downloads/cloudwallpapersmall.png
