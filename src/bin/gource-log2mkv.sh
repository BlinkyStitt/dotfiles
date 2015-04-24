#!/usr/bin/env bash
# Generates gource video (h.264) out of multiple repositories.
# Pass the repositories in command line arguments.
# based on https://gist.github.com/derEremit/1347949
# Example:
# <this.sh> logfile outfile.m4v

set -e
set -o pipefail

# allow stdin
INFILE=$1

# todo: allow this to be a parameter
OUTFILE=$2

# todo: allow args to gource and to ffmpeg
gource-log2gource.sh $INFILE -o - | \
    ffmpeg -f image2pipe -vcodec ppm -i - -codec:v libx264 -movflags faststart -vf scale=-1:720,format=yuv420p -r 30 $OUTFILE
