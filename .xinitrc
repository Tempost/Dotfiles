xrandr --setprovidoroutputsource modesetting NVIDIA-0
xrandr --auto
xrdb -merge /home/cody/.Xresources
xset +fp /home/cody/.local/share/fonts
xset fp rehash

feh --bg-fill --randomzie /home/cody/Pictures/*
exec i3
