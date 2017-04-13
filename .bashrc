# source ~/.dotfiles/command_prompt.sh
export PS1="\[\e[34m\]\D{%a.%m.%d}\[\e[34m\] \A\[\e[m\] \[\e[36m\]\u\[\e[m\]@\[\e[36m\]\h\[\e[m\]\[\e[37m\]:\[\e[m\]\[\e[32m\]\W\[\e[m\] >> "

# vi input mode for bash
set -o vi

# free ctrl-s to be forward history search by reassigning `stop` to ctrl-X
stty stop ^X

# set vim to default editor
export VISUAL=vim
export EDITOR="$VISUAL"

alias R='R -q'
alias vi="vim"
alias data="cd \"/c/Users/Paul/Dropbox/Statistics & Data\""
alias desk="cd ~/Desktop"

# tweak `ls` alias depending on system
if [ "$(uname)" == "Darwin" ]; then
    alias ls="ls -Gal"
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    alias ls="ls --color=auto -al"
fi

work() {
    sh ~/Prefs/.tmux/layouts/work.sh $1
}

lap() {
    sh ~/Prefs/.tmux/layouts/laptop.sh $1
}

arch() {
    sh ~/Prefs/.tmux/layouts/thinkpad.sh $1
}
