#
# ~/.bashrc
#

[[ $- != *i* ]] && return

alias ls='lsd'
alias cat='bat'
alias vim='nvim'
alias v='nvim'
alias line-count='find . -name \*.py | xargs wc -l'
alias ...="cd ../.."
alias ....="cd ../../.."
alias vim-new='NVIM_APPNAME="nvim-new" nvim'

alias test-jump='ssh 3.82.250.136'
alias kube-node='ssh 192.168.1.21'
alias db-node='ssh 192.168.1.20'

iter-resources() {
    arg=$1
    namespace="${arg:-default}"
    kubectl api-resources --verbs=list --namespaced -o name | xargs -n 1 kubectl get --show-kind --ignore-not-found -n $namespace
}

alias nvimconf=neovim_config()
neovim_config() {
    cd /home/cody/.config/nvim/
    nvim
}

json-logs() {
    gum style \
        --border rounded \
        --margin "1" \
        --padding "1" \
        --border-foreground "$KUBE_COLOR" \
        "Choose a $(kube_colors "Namespace")."

    namespaces=$(gum spin --spinner dot --title "Fetching namespaces.." --show-output -- \
        kubectl get namespace --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}')

    if [ -z $namespaces ]; then
        return;
    fi
    namespace_choice=$(echo $namespaces | gum filter --height=10)
    clear

    gum style \
        --border rounded \
        --margin "1" \
        --padding "1" \
        --border-foreground "$KUBE_COLOR" \
        "Choose a $(kube_colors "⎈ Pod"). ($namespace_choice)"

    pods=$(
        gum spin --spinner dot --title "Fetching pods..." --show-output -- \
            kubectl get po -n $namespace_choice --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}'
    )

    if [ -z $pods ]; then
        return;
    fi
    pod_choice=$(echo $pods | gum filter --height=10)

    kcl -n $namespace_choice $pod_choice -f | jq -R '. as $line | try (fromjson) catch $line'
}

bin-diff() {
    diff -yw200 <(xxd $1) <(xxd $2)
}

VENV_COLOR="#74d494"
KUBE_COLOR="#326ce5"

venv_colors() {
    text=$1
    gum style --foreground "$VENV_COLOR" "$text"
}

kube_colors() {
    text=$1
    gum style --foreground "$KUBE_COLOR" "$text"
}

activate() {
    gum style \
        --border rounded \
        --margin "1" \
        --padding "1" \
        --border-foreground "$VENV_COLOR" \
        "Choose a $(venv_colors "🐍Python VENV") to activate."
    choice=$(gum choose "portal" "idp-api" "auth" "internal" "migration" "scheduler" "playground", "analytics")

    case $choice in
        portal)
            . /home/cody/.local/share/virtualenvs/portal/bin/activate;
            clear
            ;;
        idp-api)
            . /home/cody/.local/share/virtualenvs/idp-api/bin/activate;
            clear
            ;;
        auth)
            . /home/cody/.local/share/virtualenvs/auth-api/bin/activate;
            clear
            ;;
        migration)
            . /home/cody/.local/share/virtualenvs/credenti-migration/bin/activate;
            clear
            ;;
        scheduler)
            . /home/cody/.local/share/virtualenvs/scheduler/bin/activate;
            clear
            ;;
        internal)
            . /home/cody/.local/share/virtualenvs/internal/bin/activate;
            clear
            ;;
        analytics)
            . /home/cody/.local/share/virtualenvs/analytics-api/bin/activate;
            clear
            ;;
        playground)
            . /home/cody/Source/python/playground/playground/bin/activate;
            clear
            ;;
    esac
}

function finstall {
    PACKAGE_NAME=$(apt-cache search $1 | fzf | cut --delimiter=" " --fields=1)
    if [ "$PACKAGE_NAME" ]; then
        echo "Installing $PACKAGE_NAME"
        sudo apt install $PACKAGE_NAME
    fi
}
