echo "setting paths"

export EDITOR=vim
export VISUAL=vim

# my scripts
export PATH="~/code/scripts:$PATH"
# misc
export PATH="~/bin:$PATH"
# homebrew
export PATH="/usr/local/bin:$PATH"

# manpath
export MANPATH="/usr/local/man:$MANPATH"

# homebrew library path
export LIBRARY_PATH="$LIBRARY_PATH:/usr/local/lib"

# - Rust
export PATH="$HOME/.cargo/bin:$PATH"
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
export RUST_BACKTRACE=1 # Rust error backtraces on by default

# - NODE_PATH management
# export NODE_PATH="/usr/local/lib/node_modules:$NODE_PATH"

# - GOPATH
export GOPATH="$HOME/code/go"
export PATH="$PATH:$GOPATH/bin"

# - rbenv aliases
# eval "$(rbenv init -)"

# PG
# export PATH="$PATH:/Applications/Postgres.app/Contents/Versions/9.3/bin"

# Heroku
export PATH="$PATH:/usr/local/heroku/bin"

# Use the assemblies under /usr/local for Mono's GAC.
# See brew info mono for (slightly) more information on this
# or read up on Mono's Global Assembly Cache
# Not currently set, because I don't use mono
# export MONO_GAC_PREFIX="/usr/local"

# - Don't check mail when opening terminal
# unset MAILCHECK
