#!/bin/bash
# example usage: trustgraph.sh 1A97F7CF
# example usage: trustgraph.sh bryan@uber.com "@uber.com Ignas"
# example usage: trustgraph.sh @uber.com "@uber.com Ignas" uber_wot

realpath() {
    [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}

if [ -n "${1}" ]; then
    KEYS=${1}
else
    echo "Usage: $0 keys filters filename"
    exit 1
fi
if [ -n "${2}" ]; then
    FILTERS=${2}
fi
if [ -n "${3}" ]; then
    FILENAME=${3}
else
    FILENAME=${KEYS}
fi

# update the keys we already have
gpg --refresh-keys $KEYS

# get the key(s) that have signed the key(s) specified
gpg --list-sigs $KEYS | grep ^sig | cut -c 14- | cut -d' ' -f1 | sort | uniq >"${FILENAME}.temp-ids"
gpg --recv-keys `cat ${FILENAME}.temp-ids`

# save the relevant key(s) to a separate keychain
gpg --export `cat ${FILENAME}.temp-ids` >"${FILENAME}.temp-gpg"

# todo: also get the keys that have been signed by the key(s) specified

# filter the separate keychain and turn it into a dot
gpg --no-default-keyring --keyring "$(realpath ${FILENAME}.temp-gpg)" --export ${FILTERS} >"${FILENAME}.gpg"
gpg --no-default-keyring --keyring "$(realpath ${FILENAME}.temp-gpg)" --list-sigs ${FILTERS} | sig2dot.pl > "${FILENAME}.dot"

rm ${FILENAME}.temp-gpg ${FILENAME}.temp-ids

open "${FILENAME}.dot"
