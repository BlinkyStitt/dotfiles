#!/bin/sh

# cd into the Uber directory ("cd -" friendly)
u() {
    if [[ $1 == "" ]]; then
        cd $UBER_HOME
        return
    fi

    local uber=$(ls $UBER_HOME | grep $1 | sort | tail -1)
    if [[ $uber != "" ]]; then
        cd $UBER_HOME/$uber
    fi
}
_uber() {
    COMPREPLY=($(compgen -W '$(ls $UBER_HOME)' -- ${COMP_WORDS[COMP_CWORD]}))
    return 0;
}
complete -o default -o nospace -F _uber u;

