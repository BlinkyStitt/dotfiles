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

read -d '' PROMPT_COMMAND <<"EOF"
LAST_STATUS_CODE=$?;
if [[ $LAST_STATUS_CODE != 0 ]]; then
    STAT_MSG="$COLOR_LIGHT_RED$LAST_STATUS_CODE$COLOR_NC";
else
    STAT_MSG="$COLOR_GREEN$LAST_STATUS_CODE$COLOR_NC";
fi;
SHORTENED_PWD=`_dir_chomp "$(pwd)" 20`;
_GIT_TMP=`__git_ps1`;
if [[ $_GIT_TMP ]]; then
    GIT_PS1="$COLOR_YELLOW$_GIT_TMP";
else
    GIT_PS1="";
fi;
if [ "$(id -u)" != "0" ]; then
    USER_COLOR="$COLOR_GREEN"
    USER_PROMPT="\$"
else
    COLOR_USER="$COLOR_BLUE"
    USER_PROMPT="\#"
fi
export PS1="$STAT_MSG $USER_COLOR\\u@\\h $COLOR_LIGHT_GREEN$SHORTENED_PWD$GIT_PS1$COLOR_GREEN $COLOR_NC$USER_PROMPT "
EOF
