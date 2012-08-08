# cd into UBER_HOME
u() {
    if [ -z $1 ]; then
        cd $UBER_HOME
        return
    fi

    local project=$(ls $UBER_HOME | grep $1 | sort | tail -1)
    if [ -n $project ]; then
        cd $UBER_HOME/$project
    fi
}
_uber() {
    COMPREPLY=($(compgen -W '$(ls $UBER_HOME)' -- ${COMP_WORDS[COMP_CWORD]}))
    return 0;
}
complete -o default -o nospace -F _uber u;

