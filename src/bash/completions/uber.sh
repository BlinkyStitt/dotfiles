if [[ -n ${UBER_HOME} && -d ${UBER_HOME} ]]; then
    echo ${UBER_HOME}

    # cd into UBER_HOME
    # todo: this is copy/pasted from ./code.sh, don't do that!
    u() {
        if [ -z $1 ]; then
            cd ${UBER_HOME}
            return
        fi

        local PROJECT=$(ls ${UBER_HOME} | grep $1 | sort | tail -1)
        if [ -n ${PROJECT} ]; then
            cd ${UBER_HOME}/${PROJECT}
        fi
    }
    _uber() {
        COMPREPLY=($(compgen -W '$(ls $1)' -- ${COMP_WORDS[COMP_CWORD]}))
        return 0;
    }

    complete -o default -o nospace -F _uber u;
fi
