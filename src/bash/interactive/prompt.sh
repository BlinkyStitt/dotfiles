#export PS1="$COLOR_GREEN[\u@\h \W]$COLOR_NC\$ "
#return

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1

# original author: Tiago Batista
function __shortpath3 {
    local pathName=${1%?}

    if [[ 3 -gt $2 ]]; then
        #the caller screwed up, do not modify anything!
        echo $1
    elif [[ ${#pathName} -gt $2 ]]; then
        len=$2-1
        echo ${pathName:0:$len}"…/"
    else
        echo $1
    fi
}
# original author: Tiago Batista
function _dir_chomp () {
    local p=${1/#$HOME/\~} b s
    s=${#p}
    while [[ $p != ${p//\/} ]]&&(($s>$2))
    do
        [[ $p =~ [^/]*/ ]]
        short=$(__shortpath3 "${BASH_REMATCH[0]}" 4)
        b=$b$short
        p=${p#*/}
        ((s=${#b}+${#p}))
    done
    echo ${b/\/~/\~}${b+}$p
}

export PS1_NC="\[$COLOR_NC\]"
export PS1_LIGHT_RED="\[$COLOR_LIGHT_RED\]"
export PS1_GREEN="\[$COLOR_GREEN\]"
export PS1_LIGHT_GREEN="\[$COLOR_LIGHT_GREEN\]"
export PS1_YELLOW="\[$COLOR_YELLOW\]"
export PS1_BLUE="\[$COLOR_BLUE\]"

function build_my_bash_prompt() {
    # status code
    LAST_STATUS_CODE=$?
    if [[ $LAST_STATUS_CODE != 0 ]]; then
        STAT_COLOR=$PS1_LIGHT_RED
    else
        STAT_COLOR=$PS1_GREEN
    fi
    STAT_MSG="$STAT_COLOR$LAST_STATUS_CODE$PS1_NC"

    # python virtualenv
    if [ -n "$VIRTUAL_ENV" ]; then
    	VIRTUALENV_PS1="(`basename \"$VIRTUAL_ENV\"`) "
    else
    	VIRTUALENV_PS1=""
    fi

    # working directory
    SHORTENED_PWD=`_dir_chomp "$(pwd)" 20`

    # git
    GIT_PS1=""
    if command_exists __git_ps1; then
        _GIT_TMP=`__git_ps1`
        if [ -n "$_GIT_TMP" ]; then
            GIT_PS1="$PS1_YELLOW$_GIT_TMP"
        fi
    fi

    # user
    if [ "$(id -u)" != "0" ]; then
        USER_COLOR="$PS1_GREEN"
        USER_PROMPT="\$"
    else
        COLOR_USER="$PS1_BLUE"
        USER_PROMPT="\#"
    fi

    # the prompt
    PS1="$STAT_MSG $VIRTUALENV_PS1$USER_COLOR\\u@\\h $PS1_LIGHT_GREEN$SHORTENED_PWD$GIT_PS1$PS1_GREEN $PS1_NC$USER_PROMPT "
}
PROMPT_COMMAND=build_my_bash_prompt
