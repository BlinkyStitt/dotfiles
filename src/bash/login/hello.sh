if shell_is_interactive; then
    # Hello Messsage --------------------------------------------------
    echo -e "${COLOR_BROWN}Kernel Information: " `uname -smr`
    echo -ne "${COLOR_GRAY}Uptime: "; uptime
    echo -ne "Server time is: "; date

    if command_exists fortune; then
        if command_exists cowsay; then
            cmd="cowsay -s -W 76"
        else
            cmd=tee
        fi
        echo "Don't forget to update your dotfiles! 'cd ~/.dotfiles; git pull'" | $cmd
    fi
    echo -ne "${COLOR_NC}"
fi
