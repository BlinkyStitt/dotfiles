if [[ -n ${CODE_HOME} && -d ${CODE_HOME} ]]; then
    # cd into the code directory
    # todo: don't hard code the dir
    c() {
        if [ -z $1 ]; then
            cd ${CODE_HOME}
            return
        fi

        local PROJECT=$(ls ${CODE_HOME} | grep $1 | sort | tail -1)
        if [ -n $PROJECT ]; then
            cd ${CODE_HOME}/$PROJECT
        fi
    }
    _c() {
        COMPREPLY=($(compgen -W '$(ls ${CODE_HOME})' -- ${COMP_WORDS[COMP_CWORD]}))
        return 0;
    }

    complete -o default -o nospace -F _c c
fi
