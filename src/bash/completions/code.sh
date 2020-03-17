#!/usr/bin/env bash
# i'm sure this could be better. but this is a quick way to get into my code directories with simple tab completion

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

    if [[ -d "${CODE_HOME}/satoshi_and_kin" ]]; then
        # cd into the code/satoshi_and_kin directory
        # todo: make this work deeper than one level
        ski() {
            local d=${1%@}

            if [ -z "$d" ]; then
                cd "${CODE_HOME}/satoshi_and_kin" || exit 1
                return
            fi

            if [ ! -d "${CODE_HOME}/satoshi_and_kin/${d}" ]; then
                echo "$1: No such project"
                return
            fi

            cd "${CODE_HOME}/satoshi_and_kin/${d}" || exit 1
            echo "cd $(pwd)"
        }
        _ski() {
            COMPREPLY=($(compgen -W '$(ls ${CODE_HOME}/satoshi_and_kin/)' -- ${COMP_WORDS[COMP_CWORD]}))
            return 0
        }

        complete -o default -o nospace -F _ski ski
    elif [[ -d "${CODE_HOME}/ski" ]]; then
        # cd into the code/ski directory
        # todo: make this work deeper than one level
        ski() {
            local d=${1%@}

            if [ -z "$d" ]; then
                cd "${CODE_HOME}/ski" || exit 1
                return
            fi

            if [ ! -d "${CODE_HOME}/ski/${d}" ]; then
                echo "$1: No such project"
                return
            fi

            cd "${CODE_HOME}/ski/${d}" || exit 1
            echo "cd $(pwd)"
        }
        _ski() {
            COMPREPLY=($(compgen -W '$(ls ${CODE_HOME}/ski/)' -- ${COMP_WORDS[COMP_CWORD]}))
            return 0
        }

        complete -o default -o nospace -F _ski ski
    fi
fi
