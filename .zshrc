# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
#
ZSH=/usr/share/oh-my-zsh
ZSH_THEME="fwalch"
plugins=(git fzf fzf-zsh-plugin zsh-completions fzf-tab)

export COLORTERM="truecolor"

export GOPATH="$HOME/.local/share/go"
export GOBIN="$GOPATH/bin"
export JAVA_HOME=/usr/lib/jvm/java-17-temurin
export JAVA_LSP=/opt/eclipse.jdt.ls
export PATH="$PATH:/home/cody/.local/bin:$GOPATH:$JAVA_HOME/bin:$JAVA_LSP/bin"
export AWS_PROFILE=823298410396_AWSPowerUserAccess
export HISTFILE="$XDG_STATE_HOME/zsh/history"
export WORKON_HOME="$XDG_DATA_HOME/virtualenvs"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export PSQL_HISTORY="$XDG_DATA_HOME/psql_history"
export NVM_DIR="$XDG_DATA_HOME/nvm"
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"
export MYSQL_HISTFILE="$XDG_DATA_HOME/mysql_history"
export MINIKUBE_HOME="$XDG_DATA_HOME/minikube"
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
export FZF_PATH="$XDG_CONFIG_HOME/fzf"

if [ -x "$(command -v tmux)" ] && [ -n "${DISPLAY}" ]; then
  [ -z "${TMUX}" ] && { tmux attach || tmux; } >/dev/null 2>&1
fi

[[ -f ~/.bash_aliases ]] && source ~/.bash_aliases

ZSH_CACHE_DIR="$HOME/.cache/oh-my-zsh"
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

source $ZSH/oh-my-zsh.sh

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# pnpm
export PNPM_HOME="/home/cody/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

[[ $commands[kubectl] ]] && source <(kubectl completion zsh)

autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit
complete -C '/usr/local/bin/aws_completer' aws
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source /usr/share/nvm/init-nvm.sh
