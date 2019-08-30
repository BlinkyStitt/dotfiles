#!/usr/bin/env bash

if shell_is_interactive; then
    # Hello Messsage --------------------------------------------------
    echo -e "${COLOR_BROWN}Kernel Information: " `uname -smr`
    echo -ne "${COLOR_GRAY}Uptime: "; uptime
    echo -ne "Server time is: "; date


    if command_exists zpool; then
        zpool status -v
    fi

    if command_exists cowsay; then
        cmd="cowsay -s -W 76"
    else
        cmd=tee
    fi

    echo "Don't forget to update! 'update-dotfiles'" | $cmd
    echo -e "${COLOR_NC}"
fi
