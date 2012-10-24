# this depends on bash completion's _cd
if [[ -n ${UBER_HOME} && -d ${UBER_HOME} ]]; then
    # cd into UBER_HOME
    # todo: this is copy/pasted from ./code.sh, don't do that!
    u() {
        if [ -z $1 ]; then
            cd ${UBER_HOME}
            return
        fi

        if [ ! -d ${UBER_HOME}/$1 ]; then
            echo "$1: No such project"
            return
        fi

        cd ${UBER_HOME}/$1
        echo "cd `pwd`"
    }
    _uber() {
        COMPREPLY=($(compgen -W '$(ls ${UBER_HOME}/)' -- ${COMP_WORDS[COMP_CWORD]}))
        return 0
    }

    complete -o default -o nospace -F _uber u;
fi
