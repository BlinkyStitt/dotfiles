if command_exists tmuxinator; then
    [[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator

    # you need to install the gem with '--no-wrappers' for this to work
    ## gem install --no-wrappers tmuxinator
    # todo: but then the tmuxinator command breaks :(
    # if command_exists tmuxinator_completion; then
    #     source `which tmuxinator_completion`
    # fi
fi
