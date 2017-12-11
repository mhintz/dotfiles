echo "loading mhintz .bash_profile"

THIS_DIR=$(dirname $0)

source $THIS_DIR/path_setup.sh

if [ -f ~/.bashrc ]; then
    source ~/.bashrc
else
    echo "bashrc file not found"
fi
