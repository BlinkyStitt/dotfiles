#!/usr/bin/env bash

# Add tab completion for SSH host names based on ~/.ssh/config, ignoring wildcards
# todo: cut off .prod.uber.internal?
if [ -r "$HOME/.ssh/config" ]; then
    complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2)" scp sftp ssh
fi
