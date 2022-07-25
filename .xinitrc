xrandr --setprovidoroutputsource modesetting NVIDIA-0
xrandr --auto
xrdb -merge $HOME/.Xresources
xset +fp $HOME/.local/share/fonts
xset fp rehash

feh --bg-fill --randomzie $HOME/Pictures/*
exec i3
