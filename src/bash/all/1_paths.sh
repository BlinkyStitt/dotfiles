# save some variables so we can safely reload without duplicating anything
if [ -z "${ORIG_PATH}" ]; then
  export ORIG_PATH=${PATH}
else
  PATH=${ORIG_PATH}
fi
if [ -z "${ORIG_DYLD_LIBRARY_PATH}" ]; then
  export ORIG_DYLD_LIBRARY_PATH="${DYLD_LIBRARY_PATH}"
else
  DYLD_LIBRARY_PATH="${ORIG_DYLD_LIBRARY_PATH}"
fi
if [ -z "${ORIG_NODE_PATH}" ]; then
  export ORIG_NODE_PATH="${NODE_PATH}"
else
  NODE_PATH="${ORIG_NODE_PATH}"
fi
if [ -z "${ORIG_PYTHONPATH}" ]; then
  export ORIG_PYTHONPATH="${PYTHONPATH}"
else
  PYTHONPATH="${ORIG_PYTHONPATH}"
fi

# macports
if [ -d "/opt/local/sbin" ]; then
  PATH="/opt/local/sbin:${PATH}"
fi
if [ -d "/opt/local/bin" ]; then
  PATH="/opt/local/bin:${PATH}"
fi

# fink
if [ -d "/sw" ]; then
  PATH="/sw/bin:${PATH}"
fi

# homebrew
if command_exists brew; then
  # if brew is already on the path. get that prefix so we can move it to the front
  BREW_ROOT=`brew --prefix`
elif [ -d "$HOME/.homebrew" ]; then
  # no brew on the path, so check the user folder
  # it is probably better to symlink brew into /usr/local/bin from here than to install here
  BREW_ROOT="$HOME/.homebrew"
fi
if [ -n "$BREW_ROOT" ]; then
  if [ -d "${BREW_ROOT}/share/python" ]; then
    PATH="${BREW_PATH}/share/python:${PATH}"
  fi
  if [ -d "${BREW_ROOT}/lib/node_modules" ]; then
    export NODE_PATH="${BREW_PATH}/lib/node_modules"
  fi
  if [ -d "${BREW_ROOT}/sbin" ]; then
    PATH="${BREW_PATH}/sbin:${PATH}"
  fi
  if [ -d "${BREW_ROOT}/bin" ]; then
    # eventhough this is already on the path, we need to make it
    # higher in priority
    PATH="${BREW_ROOT}/bin:${PATH}"
  fi
fi

# mysql
if [ -d "/usr/local/mysql" ]; then
  PATH="$PATH:/usr/local/mysql/bin"
  DYLD_LIBRARY_PATH="$DYLD_LIBRARY_PATH:/usr/local/mysql/lib"
fi

# ccache
if command_exists ccache; then
    if command_exists brew; then
        CCACHE_VERSION=`ccache -V | awk 'NR==1 {print $3}'`
        CCACHE_LIBEXEC=`brew --cellar ccache`/${CCACHE_VERSION}/libexec
        if [ -d "${CCACHE_LIBEXEC}" ]; then
            PATH="${CCACHE_LIBEXEC}:${PATH}"
        fi
    elif [ -d "/usr/lib/ccache" ]; then
        PATH="/usr/lib/ccache:${PATH}"
    fi
fi

# f90cache
if command_exists f90cache; then
    if command_exists brew; then
        F90CACHE_VERSION=`f90cache -V | awk 'NR==1 {print $3}'`
        F90CACHE_LIBEXEC=`brew --cellar f90cache`/${F90CACHE_VERSION}/libexec
        if [ -d "${F90CACHE_LIBEXEC}" ]; then
            PATH="${F90CACHE_LIBEXEC}:${PATH}"
        fi
    elif [ -d "/usr/lib/f90cache" ]; then
        PATH="/usr/lib/f90cache:${PATH}"
    fi
fi

# rvm
if [ -r "${HOME}/.rvm/scripts/rvm" ]; then
  source "${HOME}/.rvm/scripts/rvm"
fi

# postgres one click installer
if [ -d "/Library/PostgreSQL/9.1/bin" ] ; then
  PATH="$PATH:/Library/PostgreSQL/9.1/bin"
fi

# add the user's bin folder to the path
if [ -d "${HOME}/.bin" ]; then
  PATH="${HOME}/.bin:$PATH"
fi
if [ -d "${HOME}/bin" ]; then
  PATH="${HOME}/bin:$PATH"
fi

# local settings
# this is leaded separately from .bashrc.local so that it can be loaded now
if [ -r "${HOME}/.path.local" ]; then
  source "${HOME}/.path.local"
fi

export PATH DYLD_LIBRARY_PATH
# TODO: set MANPATH
#export MANPATH="/usr/local/man:/usr/local/mysql/man:/usr/local/git/man:$MANPATH"
