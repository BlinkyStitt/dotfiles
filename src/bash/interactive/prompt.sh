if command_exists brew; then
    if [ -f $(brew --prefix)/bin/liquidprompt ]; then
        . $(brew --prefix)/bin/liquidprompt
    fi
fi

