#!/bin/sh
if test -z $1; then
    name='default'
else
    name=$1
fi
tmux new-session -s $name -d 'vim'
tmux split-window -p 40
tmux split-window -h 'hive -S'
tmux last-pane
tmux split-window -h
tmux select-pane -t 0
tmux split-window -h -p 25 'ipython'
tmux attach-session -d -t $name
