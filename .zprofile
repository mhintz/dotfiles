echo "loading mhintz .zprofile"

THIS_DIR=$(dirname $0)

# homebrew security stuff
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_INSECURE_REDIRECT=1
export HOMEBREW_CASK_OPTS=--require-sha

source $THIS_DIR/path_setup.sh
