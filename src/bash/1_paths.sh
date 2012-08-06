# save the default path so we can easily reload without duplicating anything
if [ ! -n "$ORIG_PATH" ]; then
  export ORIG_PATH=$PATH
else
  PATH=$ORIG_PATH
fi

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
if command_exists brew; then
  BREW_PATH=`brew --prefix`
  # TODO: make sure brew is in /usr/local since it's a pain otherwise

  if [ -d ${BREW_PATH}/bin ]; then
    # eventhough this is already on the path, we need to make it
    # higher in priority    
    PATH=${BREW_PATH}/bin:${PATH}
  fi
  if [ -d ${BREW_PATH}/sbin ]; then
    PATH=${BREW_PATH}/sbin:${PATH}
  fi
  if [ -d ${BREW_PATH}/share/python ]; then
    PATH=${BREW_PATH}/share/python:${PATH}
  fi
  if [ -d ${BREW_PATH}/lib/node_modules ]; then
    export NODE_PATH=${BREW_PATH}/lib/node_modules
  fi

  # mysql
  if [ -d "${BREW_PATH}/mysql" ]; then
    PATH="$PATH:${BREW_PATH}/mysql/bin"
    export DYLD_LIBRARY_PATH="$DYLD_LIBRARY_PATH:${BREW_PATH}/mysql/lib"
  fi
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
