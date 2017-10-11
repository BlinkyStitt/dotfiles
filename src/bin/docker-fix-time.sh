#!/bin/sh
# this shouldn't be needed anymore, but for some reason there was still drift
# https://github.com/docker/for-mac/issues/17

echo "fixing docker time..."
exec docker run --rm --privileged alpine hwclock -s

