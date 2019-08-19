# Setup fzf
# ---------
if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
  export PATH="$PATH:/usr/local/opt/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/usr/local/opt/fzf/shell/key-bindings.zsh"

# Widget to echo a git branch name into a line (mechanics copied from the similar filename echo widget)
# ------------
__branchselect() {
  local cmd="git for-each-ref --format='%(refname:short)' refs/heads"
  setopt localoptions pipefail 2> /dev/null
  eval "$cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse $FZF_DEFAULT_OPTS" $(__fzfcmd) -m "$@" | while read item; do
    echo -n "${(q)item} "
  done
  local ret=$?
  echo
  return $ret
}

fzf-branch-widget() {
  LBUFFER="${LBUFFER}$(__branchselect)"
  local ret=$?
  zle reset-prompt
  return $ret
}
zle     -N   fzf-branch-widget
# bind to ctrl-b because the default behavior isn't necessary
bindkey '^B' fzf-branch-widget
