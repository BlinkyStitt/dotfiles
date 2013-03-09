#!/bin/bash

# Launch different bash configuration for Linux vs OSX, interactive vs batch
#
# From https://github.com/josephwecker/bashrc_dispatch by Joseph Wecker
#
# License: Public Domain.

# Configuration
# -------------
#
# EXPORT_FUNCTIONS: export SHELL_PLATFORM and shell_is_* functions for use
#                   in other scripts.

EXPORT_FUNCTIONS=true

# Code
# ----

# don't do anything if this isn't bash
[ -z "$BASH_VERSION" ] && return

# Avoid recursive invocation
[ -n "$BASHRC_DISPATCH_PID" ] && [ $$ -eq "$BASHRC_DISPATCH_PID" ] && return
BASHRC_DISPATCH_PID=$$

# Setup the main shell variables and functions

if [ -z "$SHELL_PLATFORM" ]; then
    SHELL_PLATFORM='OTHER'
    case "$OSTYPE" in
      *'linux'*   ) SHELL_PLATFORM='LINUX' ;;
      *'darwin'*  ) SHELL_PLATFORM='OSX' ;;
      *'freebsd'* ) SHELL_PLATFORM='BSD' ;;
    esac
fi

if ! type -p shell_is_login ; then
  shell_is_linux       () { [[ "$OSTYPE" == *'linux'* ]] ; }
  shell_is_osx         () { [[ "$OSTYPE" == *'darwin'* ]] ; }
  shell_is_login       () { shopt -q login_shell ; }
  shell_is_interactive () { test -n "$PS1" ; }
  shell_is_script      () { ! shell_is_interactive ; }
fi

# Make $BASH_ENV the same in interactive and non-interactive scripts
#[ -z "$BASH_ENV" ] && export BASH_ENV="$BASH_SOURCE"

# Make these available to the potentially convoluted bashrc_* startup scripts

if $EXPORT_FUNCTIONS ; then
    export SHELL_PLATFORM
    export -f shell_is_linux
    export -f shell_is_osx
    export -f shell_is_login
    export -f shell_is_interactive
    export -f shell_is_script
fi

# Now dispatch special files

# once
if [ -z "$BRCD_RANONCE" ]; then
    for i in ~/.bash/once/*.sh ; do
        if [ -r "$i" ]; then
            if shell_is_interactive; then
                . $i
            else
                . $i >/dev/null 2>&1
            fi
        fi
    done
    export BRCD_RANONCE=true
fi

# all
for i in ~/.bash/all/*.sh ; do
    if [ -r "$i" ]; then
        if shell_is_interactive; then
            . $i
        else
            . $i >/dev/null 2>&1
        fi
    fi
done

# script
if shell_is_script; then
    for i in ~/.bash/script/*.sh ; do
        if [ -r "$i" ]; then
            . $i
        fi
    done
fi

# interactive
if shell_is_interactive; then
    for i in ~/.bash/interactive/*.sh ; do
        if [ -r "$i" ]; then
            . $i
        fi
    done
fi

# login
if shell_is_login; then
    for i in ~/.bash/login/*.sh ; do
        if [ -r "$i" ]; then
            . $i
        fi
    done
fi

# Unset variables if necessary to avoid env polution

if ! $EXPORT_FUNCTIONS ; then
    unset SHELL_PLATFORM
    unset -f shell_is_linux
    unset -f shell_is_osx
    unset -f shell_is_login
    unset -f shell_is_interactive
    unset -f shell_is_script
fi

# Unset local variables

unset fn_cmd
unset EXPORT_FUNCTIONS
unset BASHRC_DISPATCH_PID
unset PRF
