#!/usr/bin/env bash

# Setup some colors to use later in interactive shell or scripts
export COLOR_NC='\033[0m' # No Color
export COLOR_WHITE='\033[1;37m'
export COLOR_BLACK='\033[0;30m'
export COLOR_BLUE='\033[0;34m'
export COLOR_LIGHT_BLUE='\033[1;34m'
export COLOR_GREEN='\033[0;32m'
export COLOR_LIGHT_GREEN='\033[1;32m'
export COLOR_CYAN='\033[0;36m'
export COLOR_LIGHT_CYAN='\033[1;36m'
export COLOR_RED='\033[0;31m'
export COLOR_LIGHT_RED='\033[1;31m'
export COLOR_PURPLE='\033[0;35m'
export COLOR_LIGHT_PURPLE='\033[1;35m'
export COLOR_BROWN='\033[0;33m'
export COLOR_YELLOW='\033[1;33m'
export COLOR_GRAY='\033[1;30m'
export COLOR_LIGHT_GRAY='\033[0;37m'
alias colorslist="set | egrep '^COLOR_\w*'"

# ls color options
export CLICOLOR=1
# a  black
# b  red
# c  green
# d  brown
# e  blue
# f  magenta
# c  cyan
# h  light grey
# A  block black, usually shows up as dark grey
# B  bold red
# C  bold green
# D  bold brown, usually shows up as yellow
# E  bold blue
# F  bold magenta
# G  bold cyan
# H  bold light grey; looks like bright white
# x  default foreground or background
export LSCOLORS=ExFxCxDxBxegedabagacad

# misc
export HISTCONTROL=ignoredups

# command line behave like vim
set -o vi

export EDITOR=vim

# bash 4 options
# todo: need to make this only run on bash 4 instead of sending to /dev/null
shopt -s autocd checkjobs globstar > /dev/null 2>&1

# this is where your own code goes
if [ -d "$HOME/code" ]; then
    export CODE_HOME="$HOME/code"
fi
if [ -d "$HOME/stitthappens" ]; then
    export STITTHAPPENS_HOME="$HOME/stitthappens"
fi
