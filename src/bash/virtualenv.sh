if command_exists virtualenvwrapper.sh; then
    source `which virtualenvwrapper.sh`
fi

if [ "$VIRTUAL_ENV" ]; then 
        source $VIRTUAL_ENV/bin/activate; 
fi 

