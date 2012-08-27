# find virtualenvwrapper.sh anywhere on your path
# export WORKON_HOME="${HOME}/.virtualenvs"   # this is the default
if command_exists virtualenvwrapper.sh; then
    source `which virtualenvwrapper.sh`
fi

# when you open tmux (or screen), you need to reload the virtual env
if [ "$APPLICATION_DIR" ]; then
    # flask-base sites have their own activate script that calls virtualenv's
    source $APPLICATION_DIR/activate
elif [ "$VIRTUAL_ENV" ]; then 
    # standard python virtualenv
    source $VIRTUAL_ENV/bin/activate; 
fi 

# virtualenv
export VIRTUALENV_USE_DISTRIBUTE=1

# pip
export PIP_DOWNLOAD_CACHE="${HOME}/.pip/cache"

# python
# this is likely only needed for some projects
# if command_exists brew; then
#   if [ -d "`brew --prefix`/lib/python2.7/site-packages" ]; then
#     export PYTHONPATH=`brew --prefix`/lib/python2.7/site-packages:$PYTHONPATH
#   fi
# fi
