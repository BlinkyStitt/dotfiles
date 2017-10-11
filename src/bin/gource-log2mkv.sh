#!/usr/bin/env bash
# Generates an mp4 out of gource logs.
# based on https://github.com/acaudwell/Gource/wiki/Videos#ffmpeg-using-x264-codec
# Example:
# <this.sh> logfile outfile.mp4

set -e
set -o pipefail

# allow stdin?
INFILE=$1

# todo: make sure this ends in .mp4
OUTFILE=$2

# todo: allow args to gource and to ffmpeg
gource-log2gource.sh $INFILE -o - | ffmpeg \
    -y \
    -r 30 \
    -f image2pipe \
    -vcodec ppm \
    -i - \
    -vcodec libx264 \
    -movflags faststart \
    -preset ultrafast \
    -pix_fmt yuv420p \
    -crf 1 \
    -threads 0 \
    -bf 0 \
    $OUTFILE
