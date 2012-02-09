for i in ~/.bash/completion_scripts/*.sh ; do
    if [ -r "$i" ]; then
        if [ "$PS1" ]; then
            . $i
        else
            . $i >/dev/null 2>&1
        fi
    fi
done

# TODO: write this in python
complete -C ~/.bash/completion_scripts/project_completion.rb -o default c

