if [ -f "$HOME/.liquidprompt/liquidprompt" ]; then
    . $HOME/.liquidprompt/liquidprompt
elif command_exists brew && [ -f $(brew --prefix)/bin/liquidprompt ]; then
    . $(brew --prefix)/bin/liquidprompt
fi
