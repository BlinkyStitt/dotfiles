if command_exists brew; then
    if [ -d "`brew --prefix uber/alt/uber-home`" ]; then
        export UBER_HOME=`brew --prefix uber/alt/uber-home`
    elif [ -d "${HOME}/Uber" ]; then
        export UBER_HOME="$HOME/Uber"
    fi
fi
