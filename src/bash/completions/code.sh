#!/usr/bin/env bash

if [[ -n ${CODE_HOME} && -d ${CODE_HOME} ]]; then
    # cd into the code directory
    # todo: make this work deeper than one level
    c() {
        local d=${1%@}

        if [ -z "$d" ]; then
            cd "${CODE_HOME}" || exit 1
            return
        fi

        if [ ! -d "${CODE_HOME}/${d}" ]; then
            echo "$1: No such project"
            return
        fi

        cd "${CODE_HOME}/${d}" || exit 1
        echo "cd $(pwd)"
    }
    _c() {
        COMPREPLY=($(compgen -W '$(ls ${CODE_HOME}/)' -- ${COMP_WORDS[COMP_CWORD]}))
        return 0
    }

    complete -o default -o nospace -F _c c
fi
