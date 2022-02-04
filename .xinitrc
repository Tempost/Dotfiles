xrandr --setprovidoroutputsource modesetting NVIDIA-0
xrandr --auto
xrdb -merge $HOME/.Xresources
xset +fp /home/tempost/.local/share/fonts
xset fp rehash

exec i3
