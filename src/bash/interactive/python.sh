# pip
#export PIP_DOWNLOAD_CACHE="${HOME}/.pip/cache"

# virtualenv
export VIRTUALENV_USE_DISTRIBUTE=1

# when you open tmux (or screen), you need to reload the virtual env
if [ "$VIRTUAL_ENV" ]; then
    . $VIRTUAL_ENV/bin/activate
fi

# find virtualenvwrapper.sh anywhere on your path
# export WORKON_HOME="${HOME}/.virtualenvs"   # this is the default
if command_exists virtualenvwrapper.sh; then
    if command_exists pyenv; then
        pyenv virtualenvwrapper
    else
        . `which virtualenvwrapper.sh`
    fi
fi