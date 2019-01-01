#! /usr/local/bin/zsh

SESSION=`basename $PWD`

tmux new-session -d -s $SESSION

tmux select-window -t $SESSION:1
tmux split-window -v
tmux select-pane -t 2
tmux split-window -h
tmux select-pane -t 1

tmux new-window -t $SESSION -a
tmux split-window -v
tmux select-pane -t 2
tmux split-window -h
tmux select-pane -t 1

tmux select-window -t $SESSION:1

tmux attach -t $SESSION
