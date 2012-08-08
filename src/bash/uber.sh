#export UBER_HOME="/Users/`whoami`/Uber"
if [ -d "${HOME}/Uber" ]; then
    export UBER_HOME="$HOME/Uber"
fi
