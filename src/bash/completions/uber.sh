if [[ -n ${UBER_HOME} && -d ${UBER_HOME} ]]; then
    # cd into UBER_HOME
    # todo: this is copy/pasted from ./code.sh, don't do that!
    u() {
        local d=${1%@}

        if [ -z "$d" ]; then
            cd "${UBER_HOME}"
            return
        fi

        if [ ! -d "${UBER_HOME}/${d}" ]; then
            echo "${d}: No such project"
            return
        fi

        cd "${UBER_HOME}/${d}"
        echo "cd $(pwd)"
    }
    _uber() {
        COMPREPLY=($(compgen -W '$(ls ${UBER_HOME}/)' -- ${COMP_WORDS[COMP_CWORD]}))
        return 0
    }

    complete -o default -o nospace -F _uber u;
fi

if [[ -n ${UBER_HOME} && -d "${UBER_HOME}/sync" ]]; then
    # cd into UBER_HOME/sync
    # todo: this is copy/pasted from ./code.sh, don't do that!
    us() {
        local d=${1%@}

        if [ -z "$d" ]; then
            cd "${UBER_HOME}/sync"
            return
        fi

        if [ ! -d "${UBER_HOME}/sync/${d}" ]; then
            echo "$d: No such project"
            return
        fi

        cd "${UBER_HOME}/sync/${d}"
        echo "cd $(pwd)"
    }
    _ubersync() {
        COMPREPLY=($(compgen -W '$(ls ${UBER_HOME}/)' -- ${COMP_WORDS[COMP_CWORD]}))
        return 0
    }

    complete -o default -o nospace -F _ubersync us;
fi
