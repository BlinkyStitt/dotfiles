#!/bin/bash
# example usage: trustgraph.sh 1A97F7CF
# example usage: trustgraph.sh bryan@uber.com "@uber.com Ignas"
# example usage: trustgraph.sh @uber.com "@uber.com Ignas" uber_wot

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
gpg --list-sigs $KEYS | grep ^sig | cut -c 14- | cut -d' ' -f1 | sort | uniq > "$FILENAME.ids"
gpg --recv-keys `cat $FILENAME.ids`

# save the relevant key(s) to a separate keychain
gpg --export `cat $FILENAME.ids` > "$FILENAME.gpg"

# todo: also get the keys that have been signed by the key(s) specified

# filter the separate keychain and turn it into a dot
# todo: `neato -Tps` looks better, but doesn't handle non-Latin1 characters
gpg --no-default-keyring --keyring "$FILENAME.gpg" --list-sigs $FILTERS | sig2dot.pl | neato -Gconcentrate=true > "$FILENAME.dot"

open "$FILENAME.dot"
