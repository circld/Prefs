source ~/.dotfiles/command_prompt.sh

# vi input mode for bash
set -o vi

# set vim to default editor
export VISUAL=vim
export EDITOR="$VISUAL"

alias R='R -q'
alias vi="vim"
alias data="cd \"/c/Users/Paul/Dropbox/Statistics & Data\""
alias desk="cd ~/Desktop"
alias todo="vi ~/todo.txt"

work() {
    sh ~/Prefs/.tmux/layouts/work.sh $1
}

lap() {
    sh ~/Prefs/.tmux/layouts/laptop.sh $1
}
