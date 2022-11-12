ZSH=~/.oh-my-zsh
ZSH_THEME="fwalch"
plugins=(git)

export GOPATH=$HOME/Source/go/
export CARGO_HOME=$HOME/.cargo/
export PNPM_HOME="/home/cody/.local/share/pnpm"
export PATH=${PATH}:$HOME/.local/bin:~/.local/scripts/bspwm/:$GOPATH/bin/:$CARGO_HOME/bin/:$PNPM_HOME
export GREENLIGHT_DB_DSN='postgres://greenlight:password@localhost/greenlight?sslmode=disable'

if [ -x "$(command -v tmux)" ] && [ -n "${DISPLAY}" ]; then
  [ -z "${TMUX}" ] && { tmux attach || tmux; } >/dev/null 2>&1
fi

[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases
alias ls='lsd'

ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

source $ZSH/oh-my-zsh.sh
