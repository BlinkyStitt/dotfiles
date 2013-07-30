#!/usr/bin/env bash
# Take a domain and search in a subdirectory of pass for matching username and
# passwords to put into the clipboard.

if [[ $# -lt 1 ]]; then
    echo "Usage: $0 domain"
    exit 1
fi

BASE_PATH="autofill"
DOMAIN=$1

PASS_PATH="${BASE_PATH}/${DOMAIN}"

USERNAMES=( $(pass ls $PASS_PATH | sed 1d | cut -d' ' -f2) )
if [[ $? -ne 0 ]]; then
    exit $?
fi
if [[ -z $USERNAMES ]]; then
    echo "No usernames found for ${DOMAIN}."
    exit 1
fi

j=0
for i in "${USERNAMES[@]}"
do
    echo "$j: $i"
    let j=$j+1
done
echo -n "Select a username: [0] "
read USER_ID

USER=${USERNAMES[${USER_ID}]}
if [[ -z $USER ]]; then
    echo "No username found with that id."
    exit 1
fi

USER_PATH="${PASS_PATH}/${USER}"

# show metadata
pass show $USER_PATH | sed 1d

# put username into the clipboard
echo -n $USER | pbcopy
read -p "'${USER}' is now in the clipboard. Press [Enter] key to continue..."

# put the password into the clipboard
pass show --clip $USER_PATH
