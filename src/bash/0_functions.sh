# this loads first so that these are available elsewhere

# utility function to check if a command exists on the PATH
command_exists() { type "$1" &> /dev/null; }

# mkdir and cd there
mkcd() { [ -n "$1" ] && mkdir -p "$@" && cd "$1"; }
