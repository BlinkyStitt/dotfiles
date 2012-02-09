# changing directory to code project
function c { cd ~/code/$1; }

# utility function to check if a command exists on the PATH
function command_exists { type "$1" &> /dev/null; }

# mkdir and cd there
function mkcd() { [ -n "$1" ] && mkdir -p "$@" && cd "$1"; }
