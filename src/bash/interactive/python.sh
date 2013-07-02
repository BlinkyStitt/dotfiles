# find virtualenvwrapper.sh anywhere on your path
# export WORKON_HOME="${HOME}/.virtualenvs"   # this is the default

if command_exists virtualenvwrapper.sh; then
    if command_exists pyenv; then
        pyenv virtualenvwrapper
    else
        source `which virtualenvwrapper.sh`
    fi
fi

# when you open tmux (or screen), you need to reload the virtual env
if [ "$VIRTUAL_ENV" ]; then
    source $VIRTUAL_ENV/bin/activate
fi

# virtualenv
export VIRTUALENV_USE_DISTRIBUTE=1

# pip
export PIP_DOWNLOAD_CACHE="${HOME}/.pip/cache"
