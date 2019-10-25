# source ~/.dotfiles/command_prompt.sh
export PS1="\[\e[34m\]\D{%a.%m.%d}\[\e[34m\] \A\[\e[m\] \[\e[36m\]\u\[\e[m\]@\[\e[36m\]\h\[\e[m\]\[\e[37m\]:\[\e[m\]\[\e[32m\]\W\[\e[m\] >> "

# vi input mode for bash
set -o vi

# ensure airline fonts display properly
export LANG='en_US.UTF-8'
export PYTHONIOENCODING=utf-8
export INPUTRC=~/.inputrc

# free ctrl-s to be forward history search by reassigning `stop` to ctrl-X
stty stop ^Z

# set vim to default editor
export VISUAL=nvim
export EDITOR="$VISUAL"

alias R='R -q'
export PATH="$HOME/.cargo/bin:$PATH"
alias vi="nvim"
alias ls_="bash -c 'ls'"

# tweak `ls` alias depending on system
if [ "$(uname)" == "Darwin" ]; then
    alias ls="ls -GalhH"
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    alias ls="ls --color=auto -al"
fi

if [ -n "$VIRTUAL_ENV" ]; then
  source "$VIRTUAL_ENV/bin/activate"
  if [ -n "$TMUX" ]; then
        tmux set-environment VIRTUAL_ENV $VIRTUAL_ENV
  fi
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
