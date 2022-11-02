https://github.com/tmux/tmux/issues/3218
https://gist.github.com/bbqtd/a4ac060d6f6b9ea6fe3aabe735aa9d95

Compile terminfo file and load it using `tic`:
```
infocmp -x tmux-256color > tmux-256color.terminfo
tic -x -e tmux-256color tmux-256color.src
```

In the tmux config, load this as the default terminal config
```
set -g default-terminal tmux-256color
```
