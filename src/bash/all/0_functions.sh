# this loads first so that these are available elsewhere

# utility function to check if a command exists on the PATH
command_exists() { type "$1" &> /dev/null; }

# Predictable SSH authentication socket location.
# todo: this does not work right if you `ssh localhost`
#STATIC_SSH_AUTH_SOCK="$HOME/.ssh/ssh-auth-sock"
#if test $SSH_AUTH_SOCK && [ $SSH_AUTH_SOCK != $STATIC_SSH_AUTH_SOCK ]; then
#    ln -sf $SSH_AUTH_SOCK $STATIC_SSH_AUTH_SOCK
#    export SSH_AUTH_SOCK=$STATIC_SSH_AUTH_SOCK
#fi

ssh-reagent () {
    for agent in $SSH_AUTH_SOCK $STATIC_SSH_AUTH_SOCK /tmp/ssh-*/agent.*; do
        export SSH_AUTH_SOCK=$agent
        if ssh-add -l 2>&1 > /dev/null; then
            echo "Found working SSH Agent: ${SSH_AUTH_SOCK}"
            ssh-add -l
            return
        fi
    done
    echo "Cannot find ssh agent - maybe you should reconnect and forward it?"
}
