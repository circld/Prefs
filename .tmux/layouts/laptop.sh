#!/bin/sh
if test -z $1; then
    name='default'
else
    name=$1
fi
tmux new-session -s $name -d
tmux split-window -p 30
tmux split-window -h -p 65
tmux select-pane -t $name:0.0
tmux split-window -h -p 35
tmux send-keys -t $name:0.0 vi C-m
tmux send-keys -t $name:0.1 ipython2 C-m
tmux send-keys -t $name:0.3 'hive -S' C-m
tmux attach-session -d -t $name
