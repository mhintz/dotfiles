echo "setting aliases"

export EDITOR=emacs

# - set up nvm
export NVM_DIR="$HOME/.nvm"
source $(brew --prefix nvm)/nvm.sh

# - Shortcuts
alias simpleserver='python2.7 -m SimpleHTTPServer 8000'
alias sublo='subl .'
alias atomo='atom .'
alias towero='gittower .'

# - Cool upgrade commands
alias brewup='brew update; brew upgrade;'
alias npmup='npm install -g npm@latest; npm update -g;'
alias pipup="pip install --upgrade pip; pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs pip install -U;"
alias pip2up="pip2 install --upgrade pip; pip2 freeze --local | grep -v '^\-e' | cut -d = -f 1 | xargs pip install -U;"
# alias gemup='gem update'

# - zsh
alias refresh='source ~/.zshrc'

alias lsl='ls -la'

# - Cargo
alias cgoc='cargo clean'
alias cgob='cargo build'
alias cgor='cargo run'

# - Git
# alias gb='git branch'
# alias gco='git checkout'
alias gs='git status'
alias gits='git status'
alias gitd='git diff'
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

# - npm
# alias npmi='npm install'
# alias npmis='npm install --save'
# alias npmisd='npm install --save-dev'
