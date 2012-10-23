#export PS1="$COLOR_GREEN[\u@\h \W]$COLOR_NC\$ "
#return

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1

_dir_chomp () {
    local p=${1/#$HOME/\~} b s
    s=${#p}
    while [[ $p != ${p//\/} ]]&&(($s>$2))
    do
        p=${p#/}
        [[ $p =~ \.?. ]]
        b=$b/${BASH_REMATCH[0]}
        p=${p#*/}
        ((s=${#b}+${#p}))
    done
    echo ${b/\/~/\~}${b+/}$p
}

export PS1_NC="\[$COLOR_NC\]"
export PS1_LIGHT_RED="\[$COLOR_LIGHT_RED\]"
export PS1_GREEN="\[$COLOR_GREEN\]"
export PS1_LIGHT_GREEN="\[$COLOR_LIGHT_GREEN\]"
export PS1_YELLOW="\[$COLOR_YELLOW\]"
export PS1_BLUE="\[$COLOR_BLUE\]"

read -d '' PROMPT_COMMAND <<"EOF"
LAST_STATUS_CODE=$?;
if [[ $LAST_STATUS_CODE != 0 ]]; then
    STAT_COLOR=$PS1_LIGHT_RED
else
    STAT_COLOR=$PS1_GREEN
fi;
STAT_MSG="$STAT_COLOR$LAST_STATUS_CODE$PS1_NC";
SHORTENED_PWD=`_dir_chomp "$(pwd)" 20`;
_GIT_TMP=`__git_ps1`;
if [[ $_GIT_TMP ]]; then
    GIT_PS1="$PS1_YELLOW$_GIT_TMP";
else
    GIT_PS1="";
fi;
if [ "$(id -u)" != "0" ]; then
    USER_COLOR="$PS1_GREEN"
    USER_PROMPT="\$"
else
    COLOR_USER="$PS1_BLUE"
    USER_PROMPT="\#"
fi
export PS1="$STAT_MSG $USER_COLOR\\u@\\h $PS1_LIGHT_GREEN$SHORTENED_PWD$GIT_PS1$PS1_GREEN $PS1_NC$USER_PROMPT "
EOF
