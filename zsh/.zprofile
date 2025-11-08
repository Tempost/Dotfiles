export XCURSOR_PATH=/usr/share/icons:$XDG_DATA_HOME/icons:$HOME/.icons

export PATH=${PATH}":$HOME/.local/scripts:/usr/local/go/bin:$XDG_DATA_HOME/cargo/bin:$XDG_DATA_HOME/cargo/env"

export EDITOR="nvim"
export SHELL="zsh"
export PAGER=most man ls
export BROWSER=zen-browser

# [ "$(tty)" = "/dev/tty1" ] && exec systemd-cat --identifier=sway sway
# [ "$(tty)" = "/dev/tty1" ] && exec hyprland
