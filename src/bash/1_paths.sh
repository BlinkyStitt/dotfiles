# macports
if [ -d /opt/local/sbin ]; then
        PATH=/opt/local/sbin:$PATH
fi
if [ -d /opt/local/bin ]; then
        PATH=/opt/local/bin:$PATH
fi

# fink
if [ -d /sw ]; then
        PATH=/sw/bin:$PATH
fi

# homebrew
if [ -d ${HOME}/.homebrew/bin ]; then
  PATH=${HOME}/.homebrew/bin:${PATH}
fi
if [ -d ${HOME}/.homebrew/sbin ]; then
  PATH=${HOME}/.homebrew/sbin:${PATH}
fi
if [ -d /usr/local/bin ]; then
  PATH=/usr/local/bin:${PATH}
fi
if [ -d /usr/local/sbin ]; then
  PATH=/usr/local/sbin:${PATH}
fi

# ccache
if command_exists ccache; then
    if command_exists brew; then
        CCACHE_VERSION=`ccache -V | awk 'NR==1 {print $3}'`
        CCACHE_LIBEXEC=`brew --cellar ccache`/${CCACHE_VERSION}/libexec
        if [ -d ${CCACHE_LIBEXEC} ]; then
            PATH=${CCACHE_LIBEXEC}:${PATH}
        fi
    elif [ -d /usr/lib/ccache ]; then
        PATH=/usr/lib/ccache:${PATH}
    fi
fi

# rvm
if [ -f ${HOME}/.rvm/scripts/rvm ]; then
    source ${HOME}/.rvm/scripts/rvm
fi

# add brew's python to the path
if command_exists python; then
    if command_exists brew; then
        POSSIBLE_PYTHON=`brew --prefix`/share/python
        if [ -d ${POSSIBLE_PYTHON} ]; then
            PATH=${POSSIBLE_PYTHON}:${PATH}
        fi
    fi
fi

# add users bin folder to the path
if [ -d ${HOME}/.bin ]; then
    PATH=${HOME}/.bin:$PATH
fi
if [ -d ${HOME}/bin ]; then
    PATH=${HOME}/bin:$PATH
fi

# local settings
if [ -e ${HOME}/.path.local ]; then
  source ${HOME}/.path.local
fi

export PATH
# TODO: set MANPATH
#export MANPATH="/usr/local/man:/usr/local/mysql/man:/usr/local/git/man:$MANPATH"
