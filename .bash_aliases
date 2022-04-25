#
# ~/.bashrc
#

[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias brc='nvim ~/.bashrc'
alias rex='nvim ~/.Xresources'
alias urex='xrdb ~/.Xresources'
alias vrc='nvim ~/.config/nvim/init.lua'
alias vim='nvim'
alias nvimconf=neovim_config()

neovim_config() {
    cd /home/cody/.config/nvim/
    nvim
}
