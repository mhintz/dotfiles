echo "loading mhintz .zshrc"

# oh-my-zsh
export ZSH=${HOME}/.oh-my-zsh

ZSH_THEME="robbyrussell"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(git kube-ps1)

source $ZSH/oh-my-zsh.sh

# shell integration stuff
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# alias setup
THIS_DIR=$(dirname $0)

source $THIS_DIR/aliases.sh

# set up bat

export BAT_THEME="ansi"

# set up fzf (https://github.com/junegunn/fzf) for the command line

# load fzf zsh commands and completion
[ -f $THIS_DIR/.fzf.zsh ] && source $THIS_DIR/.fzf.zsh

# default settings
# export FZF_TMUX=1 # command-line fzf opens in a tmux split
export FZF_CTRL_T_COMMAND='fd -H -E ".git"'
export FZF_ALT_C_COMMAND='fd -H -t d'
export FZF_DEFAULT_COMMAND='fd -H -E .git'

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

# load some cool functions
source $THIS_DIR/cool_functions.zsh
