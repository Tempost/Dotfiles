export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state
export XDG_CACHE_HOME=$HOME/.cache

export EDITOR="nvim"
export BROWSER=wslview
export SHELL="zsh"
export PATH=${PATH}":$HOME/.local/scripts:$XDG_DATA_HOME/cargo/bin:/usr/local/go/bin"
. "$XDG_DATA_HOME/cargo/env"

export PAGER=most man ls
