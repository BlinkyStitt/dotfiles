#!/usr/bin/env bash
# keep this last. if its run in the middle, sometimes the prompt gets confused

if [ -f "$HOME/.liquidprompt/liquidprompt" ]; then
    . $HOME/.liquidprompt/liquidprompt
elif command_exists brew && [ -f $(brew --prefix)/bin/liquidprompt ]; then
    . $(brew --prefix)/bin/liquidprompt
fi
