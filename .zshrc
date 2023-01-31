# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
#
ZSH=~/.oh-my-zsh
ZSH_THEME="fwalch"
plugins=(git)

export GOPATH="$HOME/.local/share/go/bin"
export JAVA_HOME=/opt/jdk-19.0.1
export JAVA_LSP=/opt/eclipse.jdt.ls
export MAVEN=/opt/apache-maven-3.8.6
export SPRING=/opt/spring-3.0.0
export GRADLE=/opt/gradle/gradle-7.6
export PATH="$PATH:/home/cody/.local/bin:$GOPATH:$JAVA_HOME/bin:$JAVA_LSP/bin:$MAVEN/bin:$SPRING/bin:$GRADLE/bin"
export AWS_PROFILE=823298410396_AWSPowerUserAccess

if [ -x "$(command -v tmux)" ] && [ -n "${DISPLAY}" ]; then
  [ -z "${TMUX}" ] && { tmux attach || tmux; } >/dev/null 2>&1
fi

[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases

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
