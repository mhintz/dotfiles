echo "loading mhintz .zshrc"

# Path to your oh-my-zsh installation.
export ZSH=${HOME}/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
)

source $ZSH/oh-my-zsh.sh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# alias setup
THIS_DIR=$(dirname $0)

source $THIS_DIR/aliases.sh

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

# fuzzy-find git branches
fbr() {
  local branches branch
  branches=$(git branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

# key bindings for the fzf preview used in the following two functions
local FZF_CMD_LINE_KEY_BINDINGS="ctrl-f:preview-down,ctrl-b:preview-up,ctrl-d:preview-page-down,ctrl-u:preview-page-up"

# find-in-file with a pretty sick interface
fif() {
  if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
  local regex="$1"
  local FZF_PREVIEW_CMD="highlight -O ansi -l --force {} 2> /dev/null | rg --colors 'match:bg:yellow' --pretty --context 8 -e \"$regex\""
  rg --hidden --files-with-matches --no-messages "$regex" | fzf --preview "$FZF_PREVIEW_CMD" --bind $FZF_CMD_LINE_KEY_BINDINGS
}

# replace-in-file
rif() {
  if [ ! "$#" -gt 1 ]; then echo "Need two strings, one search and one replace!"; return 1; fi
  setopt localoptions pipefail 2> /dev/null
  local FZF_PREVIEW_CMD="highlight -O ansi -l --force {} 2> /dev/null | rg --colors 'match:bg:yellow' --pretty --context 8 $1"
  replacefiles=$(rg --hidden --files-with-matches --no-messages $1 | fzf --multi --preview $FZF_PREVIEW_CMD --bind $FZF_CMD_LINE_KEY_BINDINGS | tr '\n' ' ' | head -c -1)
  if [ -z $replacefiles ]; then return 1; fi
  # do the replacement
  sed -e 's/'$1'/'$2'/g' -i '' $replacefiles
}
