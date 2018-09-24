#!/usr/bin/env bash

# save some variables so we can safely reload without duplicating anything
if [ -z "${ORIG_PATH}" ]; then
  export ORIG_PATH=${PATH}
else
  PATH=${ORIG_PATH}
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

# ccache
if command_exists ccache; then
    if command_exists brew; then
        CCACHE_LIBEXEC=`brew --prefix ccache`/libexec
        if [ -d "${CCACHE_LIBEXEC}" ]; then
            PATH="${CCACHE_LIBEXEC}:${PATH}"
        fi
    elif [ -d "/usr/lib/ccache" ]; then
        PATH="/usr/lib/ccache:${PATH}"
    fi
fi

# homedir bin
if [ -d "${HOME}/.bin" ]; then
  PATH="$PATH:${HOME}/.bin"
fi
if [ -d "${HOME}/bin" ]; then
  PATH="$PATH:${HOME}/bin"
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
  # generally I use nvm, but support brew-installed node
  if [ -d "${BREW_ROOT}/lib/node_modules" ]; then
    export NODE_PATH="${BREW_PATH}/lib/node_modules"
  fi
  if [ -d "${BREW_ROOT}/sbin" ]; then
    PATH="${BREW_ROOT}/sbin:${PATH}"
  fi
  if [ -d "${BREW_ROOT}/bin" ]; then
    # eventhough this is already on the path, we need to make it higher priority
    PATH="${BREW_ROOT}/bin:${PATH}"
  fi
fi

# rust
if [ -d "$HOME/.cargo/bin" ]; then
  export PATH="$PATH:$HOME/.cargo/bin"
fi

# nodejs
if [ -r "${HOME}/.nvm/nvm.sh" ]; then
  source "${HOME}/.nvm/nvm.sh"
fi

# https://github.com/MestreLion/git-tools.git
if [ -d "${HOME}/.git-tools" ]; then
  export PATH="$PATH:$HOME/.git-tools"
fi

# local settings
# load this now so that the rest of the scripts have access to the complete PATH
if [ -r "${HOME}/.path.local" ]; then
  source "${HOME}/.path.local"
fi

export PATH NODE_PATH PYTHONPATH
