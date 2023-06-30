# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
#
ZSH=/usr/share/oh-my-zsh
ZSH_THEME="fwalch"
plugins=(git)

export GOPATH="$HOME/.local/share/go"
export GOBIN="$GOPATH/bin"
export JAVA_HOME=/usr/lib/jvm/java-17-temurin
export JAVA_LSP=/opt/eclipse.jdt.ls
export MAVEN=/opt/apache-maven-3.8.6
export SPRING=/opt/spring-3.0.0
export GRADLE=/opt/gradle/gradle-7.6
export PATH="$PATH:/home/cody/.local/bin:$GOPATH:$JAVA_HOME/bin:$JAVA_LSP/bin:$MAVEN/bin:$SPRING/bin:$GRADLE/bin"
export AWS_PROFILE=823298410396_AWSPowerUserAccess
export HISTFILE="$XDG_STATE_HOME"/zsh/history
export WORKON_HOME="$XDG_DATA_HOME/virtualenvs"
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export PSQL_HISTORY="$XDG_DATA_HOME/psql_history"
export OMNISHARPHOME="$XDG_CONFIG_HOME"/omnisharp
export NVM_DIR="$XDG_DATA_HOME"/nvm
export NUGET_PACKAGES="$XDG_CACHE_HOME"/NuGetPackages
export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node_repl_history
export MYSQL_HISTFILE="$XDG_DATA_HOME"/mysql_history
export MINIKUBE_HOME="$XDG_DATA_HOME"/minikube
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker

export DPCPP_HOME=~/Source/c_cpp/sycl_workspace

if [ -x "$(command -v tmux)" ] && [ -n "${DISPLAY}" ]; then
  [ -z "${TMUX}" ] && { tmux attach || tmux; } >/dev/null 2>&1
fi

[[ -f ~/.bash_aliases ]] && source ~/.bash_aliases

ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

source $ZSH/oh-my-zsh.sh

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

if [ -e /home/cody/.nix-profile/etc/profile.d/nix.sh ]; then . /home/cody/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

# pnpm
export PNPM_HOME="/home/cody/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

[[ $commands[kubectl] ]] && source <(kubectl completion zsh)

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
