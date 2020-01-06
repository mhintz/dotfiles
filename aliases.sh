echo "setting aliases"

# - Shortcuts
alias simpleserver='python2.7 -m SimpleHTTPServer 8000'
alias sublo='subl .'
alias atomo='atom .'
alias towero='gittower .'
alias venv='source ./venv/bin/activate'

# - Cool upgrade commands
alias brewup='brew update; brew upgrade;'
alias npmup='npm install -g npm@latest; npm update -g;'
alias yarnup='yarn global upgrade;'
alias pipup="pip3 install --upgrade pip; pip3 freeze --local | grep -v '^\-e' | cut -d = -f 1 | xargs pip3 install -U;"
alias pip2up="pip2 install --upgrade pip; pip2 freeze --local | grep -v '^\-e' | cut -d = -f 1 | xargs pip2 install -U;"
alias gemup='gem update'

# - Python alias
alias python='python3'
alias pip='pip3'

# - zsh
alias refresh='source ~/.zshrc'

alias l='ls -a -1 -X --file-type --color --human-readable'
alias lsl='ls -a -l --human-readable'

alias v='nvim'

alias howdeep='echo $SHLVL'

# /shrug might not work? shells are weird
isgitdir() {
    command -v git && git rev-parse --show-toplevel 2>/dev/null
}

# - Ctags
makectags() {
    CTAGS_CMD='ctags -f .tags -L-'
    if [[ $(command -v fd) ]]; then
        fd -H -E '.git' | eval $CTAGS_CMD 
    elif [[ $(command -v git) && $(git rev-parse --show-toplevel 2>/dev/null) ]]; then
        git ls-files | eval $CTAGS_CMD
    elif [[ $(command -v rg) ]]; then
        rg --hidden --files | eval $CTAGS_CMD
    else
        find . | eval $CTAGS_CMD
    fi
}

space_seq() { seq $1 $2 | tr '\n' ' ' | head -c -1 }

# find the commit which merged $2 into $1
find_merge_for() {
  git log $2..$1 --ancestry-path --merges --reverse
}

# - Cargo
alias cgoc='cargo clean'
alias cgob='cargo build'
alias cgor='cargo run'

# - Git
# alias gb='GIT_PAGER=cat git branch'
alias gs='git status'
alias gcn='git commit -n'
alias gits='git status'
alias gitd='git diff'
alias gdc='git diff --cached'
alias gita='git add'
alias gitaa='git add --all'
alias gitc='git commit'
alias gitca='git commit --all'
alias gmc="git merge --continue"
alias gitf='git fetch'
alias gitfr='git fetch; git rebase'
alias gitpl='git pull'
alias gitpr='git pull --rebase'
alias gitpo='git push origin'
alias gsl='git stash list'
alias gf='git fetch --no-tags'
alias gr='git restore'

# - General Sweetness
alias weather='curl wttr.in'
