#!/bin/zsh
work_dir="$PWD"
SESSION="vscode/`basename ${work_dir//./-}`"
tmux attach-session -d -t $SESSION || tmux new-session -s $SESSION
