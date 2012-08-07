#!/bin/sh

# cd into the Uber directory ("cd -" friendly)
c() {
    if [[ $1 == "" ]]; then
        cd $CODE_HOME
        return
    fi

    local thedir=$(ls $CODE_HOME | grep $1 | sort | tail -1)
    if [[ $thedir != "" ]]; then
        cd $CODE_HOME/$thedir
    fi
}
_c() {
    COMPREPLY=($(compgen -W '$(ls $CODE_HOME)' -- ${COMP_WORDS[COMP_CWORD]}))
    return 0;
}
complete -o default -o nospace -F _c c

