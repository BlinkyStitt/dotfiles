if command_exists virtualenvwrapper.sh; then
    source `which virtualenvwrapper.sh`
fi

if [ "$APPLICATION_DIR" ]; then
    source $APPLICATION_DIR/activate
elif [ "$VIRTUAL_ENV" ]; then 
    source $VIRTUAL_ENV/bin/activate; 
fi 

