THIS_DIR=$(dirname $(readlink -f $0))

# will need to have homebrew and oh my zsh installed

# Brewfile
brew bundle install --file=$THIS_DIR/Brewfile

# initial rustup installs, some other stuff requires this
brew install rustup
rustup-init
rustup install stable
rustup target add wasm32-unknown-unknown
rustup component add clippy rls rust-analysis rust-src rustfmt rust-docs
rustup component add rustfmt --toolchain nightly

# install terminfo config for tmux-256color
# tic -x -e tmux-256color tmux-256color.terminfo
# (or the other terminfo file at terminfo/tmux-256color-v2.terminfo)

# zprofile symlinks
ln -s $THIS_DIR/.zprofile ~/.zprofile
source ~/.zprofile

# yarn symlinks (need to install contents of package.json manually)
# ln -s $THIS_DIR/package.json $(yarn global dir)/package.json

# rust/cargo installs (need to install contents of .crates.toml manually)
# ln -s $THIS_DIR/.crates.toml ~/.cargo/.crates.toml

# vim / nvim symlinks
mkdir -p ~/.config
ln -s $THIS_DIR/.vim ~/.vim
ln -s $THIS_DIR/nvim ~/.config/nvim
# vim-plug setup
curl -fLo $THIS_DIR/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
mkdir -p $THIS_DIR/nvim/autoload
ln -s $THIS_DIR/.vim/autoload/plug.vim $THIS_DIR/nvim/autoload/plug.vim

# tmux config
ln -s $THIS_DIR/.tmux.conf ~/.tmux.conf
ln -s $THIS_DIR/.tmuxline-snapshot ~/.tmuxline-snapshot

# fzf.zsh
ln -s $THIS_DIR/.fzf.zsh ~/.fzf.zsh

# zshrc
ln -s $THIS_DIR/.zshrc ~/.zshrc
source ~/.zshrc

