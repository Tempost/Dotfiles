# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
#
ZSH=/usr/share/oh-my-zsh/
ZSH_THEME="fwalch"
plugins=(git)

export GOPATH=$HOME/Source/go/
export PATH=${PATH}":/home/tempost/.local/share/gem/ruby/3.0.0/bin"
export PATH=${PATH}":/home/tempost/.local/bin"

if [ -x "$(command -v tmux)" ] && [ -n "${DISPLAY}" ]; then
  [ -z "${TMUX}" ] && { tmux attach || tmux; } >/dev/null 2>&1
fi

[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases

ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

source $ZSH/oh-my-zsh.sh
