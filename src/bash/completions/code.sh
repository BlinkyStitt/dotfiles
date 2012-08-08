# cd into the code directory
c() {
    if [ -z $1 ]; then
        cd $CODE_HOME
        return
    fi

    local project=$(ls $CODE_HOME | grep $1 | sort | tail -1)
    if [ -n $project ]; then
        cd $CODE_HOME/$project
    fi
}
_c() {
    COMPREPLY=($(compgen -W '$(ls $CODE_HOME)' -- ${COMP_WORDS[COMP_CWORD]}))
    return 0;
}
complete -o default -o nospace -F _c c
