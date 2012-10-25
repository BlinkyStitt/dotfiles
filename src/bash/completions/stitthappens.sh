if [[ -n ${STITTHAPPENS_HOME} && -d ${STITTHAPPENS_HOME} ]]; then
    # cd into stitthappens directory
    s() {
        if [ -z $1 ]; then
            cd ${STITTHAPPENS_HOME}
            return
        fi

        if [ ! -d ${STITTHAPPENS_HOME}/$1 ]; then
            echo "$1: No such project"
            return
        fi

        cd ${STITTHAPPENS_HOME}/$1
        echo "cd `pwd`"
    }
    _s() {
        COMPREPLY=($(compgen -W '$(ls ${STITTHAPPENS_HOME}/)' -- ${COMP_WORDS[COMP_CWORD]}))
        return 0;
    }

    complete -o default -o nospace -F _s s
fi
