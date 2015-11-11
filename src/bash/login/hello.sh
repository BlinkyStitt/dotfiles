if shell_is_interactive; then
    # Hello Messsage --------------------------------------------------
    echo -e "${COLOR_BROWN}Kernel Information: " `uname -smr`
    echo -ne "${COLOR_GRAY}Uptime: "; uptime
    echo -ne "Server time is: "; date
    echo -e "${COLOR_NC}Don't forget to update your dotfiles!"

    if command_exists fortune; then
        if command_exists cowsay; then
            fortune -s | cowsay -s -W 76
        else
            fortune -s
        fi
    fi
fi
