#
# ~/.bashrc
#

[[ $- != *i* ]] && return

alias ls='lsd'
alias brc='nvim ~/.bashrc'
alias rex='nvim ~/.Xresources'
alias urex='xrdb ~/.Xresources'
alias vrc='nvim ~/.config/nvim/init.lua'
alias vim='nvim'
alias update-pkgs='sudo apt-get update && sudo apt-get -y upgrade'
alias api-activate='. ~/.virtualenvs/credenti-apis/bin/activate'

alias nvimconf=neovim_config()
neovim_config() {
    cd /home/cody/.config/nvim/
    nvim
}

activate() {
    if [ $# = 0 ]; then
        printf "Enter a env.\n"
        return
    fi

    if [ $1 = "api" ]; then
        .  ~/.virtualenvs/credenti-apis/bin/activate
    elif [ $1 = "migration" ]; then
        . ~/.virtualenvs/credenti-migration/bin/activate
    else
        printf "Not a env.\n"
    fi

}
