#!/usr/bin/env bash
# Generates gource video (h.264) out of multiple repositories.
# Pass the repositories in command line arguments.
# Example:
# <this.sh> /path/to/repo1 /path/to/repo2

OUTFILE="gource.mp4"

set -x

combined_log="$(mktemp /tmp/gource_combined.XXXXXX)"
for repo in $*; do
    # output the repo to a logfile
    logfile="$(mktemp /tmp/gource.XXXXXX)"
    gource --output-custom-log "${logfile}" ${repo}

    # namespace the repos
    sed -E 's/(.+)\|/\1\|\/'${repo}'/' ${logfile} >> $combined_log

    # delete temp logfile
    rm ${logfile}
done

# sort the combined_log
sort -n -o $combined_log $combined_log

# run the log through gource and ouput to ffmpeg
# todo: lots of possible flags to pass
time gource -o - --time-scale 4.0 $combined_log | ffmpeg -y -r 60 -f image2pipe -vcodec ppm -i - -vcodec libx264 -preset ultrafast -pix_fmt yuv420p -crf 1 -threads 0 -bf 0 $OUTFILE

# cleanup the log
rm $combined_log
