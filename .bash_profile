echo "loading mhintz .bash_profile"

if [ -f ~/.bashrc ]; then
    source ~/.bashrc
else
    echo "bashrc file not found"
fi
