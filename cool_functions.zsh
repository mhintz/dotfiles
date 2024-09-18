echo "loading cool functions"

# fuzzy-find git branches
fbr() {
  local branches branch
  branches=$(git branch -vv) &&
  branch=$(echo "$branches" | fzf +m --layout=reverse --height=20) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

# key bindings for the fzf preview used in the following two functions
local FZF_CMD_LINE_KEY_BINDINGS="ctrl-f:preview-down,ctrl-b:preview-up,ctrl-d:preview-page-down,ctrl-u:preview-page-up"

# find-in-file with a pretty sick interface
fif() {
  if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
  local regex="$1"
  local FZF_PREVIEW_CMD="highlight -O ansi -l --force {} 2> /dev/null | rg --colors 'match:bg:yellow' --pretty --context 8 -e \"$regex\""
  rg --hidden --files-with-matches --no-messages "$regex" | fzf --multi --preview "$FZF_PREVIEW_CMD" --bind $FZF_CMD_LINE_KEY_BINDINGS
}

ere_quote() {
    sed 's/[]\.|$(){}?+*^]/\\&/g' <<< "$*"
}

# replace-in-file
rif() {
  if [ ! "$#" -gt 1 ]; then echo "Need two strings, one search and one replace!"; return 1; fi
  setopt localoptions pipefail 2> /dev/null
  local FZF_PREVIEW_CMD="highlight -O ansi -l --force {} 2> /dev/null | rg --colors 'match:bg:yellow' --pretty --context 8 $1"
  replacefiles=$(rg --hidden --files-with-matches --no-messages "$1" | fzf --multi --preview $FZF_PREVIEW_CMD --bind $FZF_CMD_LINE_KEY_BINDINGS | tr '\n' ' ' | head -c -1)
  if [ -z $replacefiles ]; then return 1; fi
  # do the replacement
  sed -e "s/$1/$2/g" -i '' $replacefiles
}

# work towards an incremental replace-in-file with preview
# -> rg with vimgrep output
# -> fzf per match
# -> extract the filename from the match and pass to highlight
# -> extract the line from the match and clip that line, plus context, from the output of highlight
# -> pass the clipped result to rg again to highlight the match (rg --colors 'match:bg:yellow' --pretty --context X)
# -> for any selected matches, use sed or awk to make the substitution at that line / column
# rg --color always --vimgrep foobar | fzf --ansi --bind "ctrl-f:preview-down,ctrl-b:preview-up,ctrl-d:preview-page-down,ctrl-u:preview-page-up" --preview "echo {} | rg -o '\S+\s' | tr ':' '\n' | head -n 1 | xargs highlight -O ansi -l --force 2> /dev/null | rg --colors 'match:bg:yellow' --pretty --context 8 foobar"

# "Open PR"
# Tags two arguments:
# 1: line number in a file
# 2: name of the file
# Uses those arguments, plus the github API, to find the PR associated with adding that line / the most recent git blame change for that line of code
function opr {
  if [ ! "$#" -eq 2 ]; then echo "Need a line number and a file name"; return 1; fi
  local line_num="$1"
  local file_name="$2"
  local commit_sha=$(git blame -L $1 -wCCC $2 | head -n 1 | rg -e '^[\d\w]+' -o)
  gh api "/repos/{owner}/{repo}/commits/$commit_sha/pulls" | jq -r '.[0]._links.html.href' | xargs open
}
