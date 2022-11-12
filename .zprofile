export EDITOR="nvim"
export BROWSER="google-chrome-stable"
export SHELL="zsh"
export TERM=alacritty

export PAGER=most man ls
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx -- vt1
fi
# [[ $(fgconsole 2>/dev/null) == 1 ]] && exec startx -- vt1 &> /dev/null
