#!/bin/sh
if test -z $1; then
    name='default'
else
    name=$1
fi
tmux new-session -s $name -d 'vim'
tmux split-window -h -p 30
tmux split-window 'ipython2'
tmux attach-session -d -t $name
