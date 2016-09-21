# source ~/.dotfiles/command_prompt.sh
export PS1="\[\e[34m\]\D{%a.%m.%d}\[\e[34m\] \A\[\e[m\] \[\e[36m\]\u\[\e[m\]@\[\e[36m\]\h\[\e[m\]\[\e[37m\]:\[\e[m\]\[\e[32m\]\W\[\e[m\] >> "

# vi input mode for bash
set -o vi

# set vim to default editor
export VISUAL=vim
export EDITOR="$VISUAL"

alias R='R -q'
alias vi="vim"
alias data="cd \"/c/Users/Paul/Dropbox/Statistics & Data\""
alias desk="cd ~/Desktop"
alias ls="ls --color=auto -al"

work() {
    sh ~/Prefs/.tmux/layouts/work.sh $1
}

lap() {
    sh ~/Prefs/.tmux/layouts/laptop.sh $1
}

arch() {
    sh ~/Prefs/.tmux/layouts/thinkpad.sh $1
}
