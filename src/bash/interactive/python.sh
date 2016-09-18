# pip

if command_exists pyenv; then
    eval "$(pyenv init -)"
    if command_exists pyenv-virtualenv-init; then
        eval "$(pyenv virtualenv-init -)"
    fi
fi

# when you open tmux (or screen), you need to reload the virtual env
if [ "$VIRTUAL_ENV" ]; then
    . $VIRTUAL_ENV/bin/activate
fi
