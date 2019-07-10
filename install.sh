THIS_DIR=$(dirname $(readlink -f $0))

# will need to have homebrew and oh my zsh installed

# initial install, some other stuff requires this
brew install rustup
rustup install stable

# zprofile
ln -s $THIS_DIR/.zprofile ~/.zprofile
source ~/.zprofile

# brew
brew bundle install --file=$THIS_DIR/Brewfile

# yarn (need to install contents of package.json manually)
ln -s $THIS_DIR/package.json $(yarn global dir)/package.json

# rust/cargo (need to install contents of .crates.toml manually)
ln -s $THIS_DIR/.crates.toml ~/.cargo/.crates.toml

# vim
mkdir -p ~/.config
ln -s $THIS_DIR/.vim ~/.vim
ln -s $THIS_DIR/nvim ~/.config/nvim

# tmux
ln -s $THIS_DIR/.tmux.conf ~/.tmux.conf
ln -s $THIS_DIR/.tmuxline-snapshot ~/.tmuxline-snapshot

# fzf
ln -s $THIS_DIR/.fzf.zsh ~/.fzf.zsh

# zshrc
ln -s $THIS_DIR/.zshrc ~/.zshrc
source ~/.zshrc

