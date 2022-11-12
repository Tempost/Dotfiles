#
# ~/.bashrc
#

[[ $- != *i* ]] && return

alias ls='lsd --color=auto'
alias brc='nvim ~/.bashrc'
alias rex='nvim ~/.Xresources'
alias urex='xrdb ~/.Xresources'
alias vrc='nvim ~/.config/nvim/init.lua'
alias vim='nvim'
alias gdb-arm='arm-none-eabi-gdb'

function stea () {
    cd /home/cody/Source/ts/stea
    tmux neww \
        'cd /home/cody/Source/ts/stea ; if ; [[ ! -d node_modules/ ]] && [[ ! -f yarn.lock ]] ; then ; yarn install ; fi ; yarn run dev' \; 
        set -s remain-on-exit on
    tmux select-window -t ^
    clear
}
