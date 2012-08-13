_fab_completion()
{
    COMPREPLY=()

    local cur
    if [ -f "fabfile.py" ]; then
        cur="${COMP_WORDS[COMP_CWORD]}"
        COMPREPLY=( $(compgen -W "$(fab -F short -l)" -- ${cur}) )
        return 0
    else
        # no fabfile.py found. Don't do anything.        
        return 1
    fi
}
complete -F _fab_completion fab
