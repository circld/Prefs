#!/bin/sh
if test -z $1; then
    name='default'
else
    name=$1
fi
tmux new-session -s $name -d 'vim'
tmux split-window -p 30
tmux split-window -h -p 65 'hive -S'
tmux select-pane -t 0
tmux split-window -h -p 35 'ipython'
tmux attach-session -d -t $name
