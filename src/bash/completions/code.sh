if [[ -n ${CODE_HOME} && -d ${CODE_HOME} ]]; then
    # cd into the code directory
    # todo: don't hard code the dir
    c() {
        if [ -z $1 ]; then
            cd ${CODE_HOME}
            return
        fi

        if [ ! -d ${CODE_HOME}/$1 ]; then
            echo "$1: No such project"
            return
        fi

        cd ${CODE_HOME}/$1
    }
    _c() {
        COMPREPLY=($(compgen -W '$(ls ${CODE_HOME})' -- ${COMP_WORDS[COMP_CWORD]}))
        return 0;
    }

    complete -o default -o nospace -F _c c
fi
