if [ -d "$UBER_HOME" ]; then
	alias cinfo="ssh mgmt01-peak1 clusto info"
	alias clp="ssh mgmt01-peak1 clusto list-pool --recursive"
fi
