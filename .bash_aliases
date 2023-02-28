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
alias line-count='find . -name \*.py | xargs wc -l'
alias kgp='kubectl get pods'
alias kgs='kubectl get svc'
alias kcl='kubectl logs'
alias kc='kubectl'
alias ...="cd ../.."
alias ....="cd ../../.."

alias nvimconf=neovim_config()
neovim_config() {
    cd /home/cody/.config/nvim/
    nvim
}

VENV_COLOR="#74d494"

venv_colors() {
    text=$1
    gum style --foreground "$VENV_COLOR" "$text"
}

activate() {
    gum style \
        --border rounded \
        --margin "1" \
        --padding "1" \
        --border-foreground "$VENV_COLOR" \
        "Choose a $(venv_colors "🐍Python VENV") to activate."
    choice=$(gum choose "api" "migration" "scheduler" "django-poc")

    case $choice in
        api)
            .  ~/.virtualenvs/credenti-apis/bin/activate;
            clear
            ;;
        migration)
            . ~/.virtualenvs/credenti-migration/bin/activate;
            clear
            ;;
        scheduler)
            . ~/.virtualenvs/scheduler/bin/activate;
            clear
            ;;
        django-poc)
            . ~/.virtualenvs/django-poc/bin/activate;
            clear
            ;;
    esac
}
