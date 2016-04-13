#!/bin/sh
if test -z $1; then
    name='default'
else
    name=$1
fi
tmux new-session -s $name -d
tmux split-window -h -p 30
tmux split-window
tmux send-keys -t $name:0.2 ipython2 C-m
tmux send-keys -t $name:0.0 vi C-m
tmux attach-session -d -t $name
