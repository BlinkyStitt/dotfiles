# this loads first so that these are available elsewhere

# utility function to check if a command exists on the PATH
command_exists() { type "$1" &> /dev/null; }

# Predictable SSH authentication socket location.
STATIC_SSH_AUTH_SOCK="$HOME/.ssh/ssh-auth-sock"
if test $SSH_AUTH_SOCK && [ $SSH_AUTH_SOCK != $STATIC_SSH_AUTH_SOCK ]
then
    ln -sf $SSH_AUTH_SOCK $STATIC_SSH_AUTH_SOCK
    export SSH_AUTH_SOCK=$STATIC_SSH_AUTH_SOCK
fi
