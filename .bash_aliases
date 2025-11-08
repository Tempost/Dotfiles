#
# ~/.bashrc
#

[[ $- != *i* ]] && return

alias ls='lsd'
alias cat='bat'
alias vim='nvim'
alias vi='nvim'
alias v='nvim'
alias niri_conf='nvim $XDG_CONFIG_HOME/niri/config.kdl'
alias line-count='find . -name \*.py | xargs wc -l'
alias wget='wget --hsts-file=$XDG_DATA_HOME/wget-hsts'

alias get_esprs='. $HOME/export-esp.sh'
alias get_idf='. /opt/esp-idf/export.sh'

bin-diff() {
	diff -yw200 <(xxd "$1") <(xxd "$2")
}
