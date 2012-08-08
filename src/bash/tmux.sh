if command_exists tmuxinator; then
    [[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator

    # todo: make this work
    #if command_exists tmuxinator_completion; then
    #    source `which tmuxinator_completion`
    #fi
fi
