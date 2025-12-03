#!/bin/sh

set +e

dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=wlroots

# notify
swaync &

# background
sh "$HOME"/.local/scripts/wallpaper

# Start xdg-desktop-portal-wlr
pkill -f /usr/lib/xdg-desktop-portal-wlr
/usr/lib/xdg-desktop-portal-wlr &

# Start xdg-desktop-portal-gtk
pkill -f /usr/lib/xdg-desktop-portal-gtk
/usr/lib/xdg-desktop-portal-gtk &

# Start xdg-desktop-portal-gnome
pkill -f /usr/lib/xdg-desktop-portal-gnome
/usr/lib/xdg-desktop-portal-gnome &

# keep clipboard content
wl-clip-persist --clipboard regular --reconnect-tries 0 &

# clipboard content manager
wl-paste --type text --watch cliphist store &

pkill -f steam
steam -silent &

pkill -f legcord
legcord &
