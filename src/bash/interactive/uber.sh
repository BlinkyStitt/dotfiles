if command_exists brew; then
    if [ -d "`brew --prefix WyseNynja/uber/uber-home`" ]; then
        export UBER_HOME=`brew --prefix WyseNynja/uber/uber-home`
    elif [ -d "`brew --prefix uber/uber/uber-home`" ]; then
        export UBER_HOME=`brew --prefix uber/uber/uber-home`
    elif [ -d "${HOME}/Uber" ]; then
        export UBER_HOME="$HOME/Uber"
    fi
fi
