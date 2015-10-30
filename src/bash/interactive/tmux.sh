if command_exists tmuxinator; then
    [[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator

    # you need to install the gem with '--no-wrappers' for this to work
    ## gem install --no-wrappers tmuxinator
    # todo: but then the tmuxinator command breaks :(
    # if command_exists tmuxinator_completion; then
    #     source `which tmuxinator_completion`
    # fi
fi

# fix ssh agent inside tmux
AUTH_SOCK_LINK="${HOME}/.ssh/auth_sock"
[[ -h $AUTH_SOCK_LINK && -z $TMUX && ! "$SSH_CLIENT" =~ "127.0.0.1" ]] && unlink $AUTH_SOCK_LINK
[[ -z $TMUX && ! "$SSH_CLIENT" =~ "127.0.0.1" ]] && ln -s $SSH_AUTH_SOCK $AUTH_SOCK_LINK
export SSH_AUTH_SOCK=$AUTH_SOCK_LINK
