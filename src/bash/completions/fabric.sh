_fab_completion()
{
    if ! command_exists fab; then
        return 1
    fi

    COMPREPLY=()

    local cur
    local result=`fab -F short -l 2> /dev/null`
    if [ $? -eq 0 ]; then
        cur="${COMP_WORDS[COMP_CWORD]}"
        COMPREPLY=( $(compgen -W "${result}" -- ${cur}) )
        return 0
    else
        # no fabfile.py found. Don't do anything.
        return 1
    fi
}
complete -o nospace -F _fab_completion fab
