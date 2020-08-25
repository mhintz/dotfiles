echo "setting paths"

THIS_DIR=$(dirname $0)

export EDITOR=nvim
export VISUAL=nvim

# misc scripts
export PATH="$THIS_DIR/scripts:$PATH"

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

# - GOPATH
export GOPATH="$HOME/code/go"
export PATH="$PATH:$GOPATH/bin"
eval "$(gimme 1.12.5)"

# Heroku
export PATH="$PATH:/usr/local/heroku/bin"

# Use the assemblies under /usr/local for Mono's GAC.
# See brew info mono for (slightly) more information on this
# or read up on Mono's Global Assembly Cache
# Not currently set, because I don't use mono
# export MONO_GAC_PREFIX="/usr/local"

# - Don't check mail when opening terminal
# unset MAILCHECK
