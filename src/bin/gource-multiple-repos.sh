#!/usr/bin/env bash
# Generates gource video (h.264) out of multiple repositories.
# Pass the repositories in command line arguments.
# based on https://gist.github.com/derEremit/1347949
# Example:
# <this.sh> /path/to/repo1 /path/to/repo2

RESOLUTION="1280x720"
OUTFILE="gource.webm"
COMBINED_LOG="$(mktemp /tmp/gource.XXXXXX)"
SORTED_LOG="$(mktemp /tmp/gource.XXXXXX)"

i=0
# todo: this doesn't play nice filenames with spaces
for repo in $*; do
    echo "Processing ${repo}..."
    # 1. Generate a Gource custom log files for each repo. This can be facilitated by the --output-custom-log FILE option of Gource as of 0.29:
    logfile="$(mktemp /tmp/gource.XXXXXX)"
    gource --output-custom-log "${logfile}" ${repo} && EXIT_CODE=0 || EXIT_CODE=$?
    if [ $EXIT_CODE -eq 0 ]; then
        # 2. If you want each repo to appear on a separate branch instead of merged onto each other (which might also look interesting), you can use a 'sed' regular expression to add an extra parent directory to the path of the files in each project:
        sed -E "s#(.+)\|#\1|${repo}#" ${logfile} >> $COMBINED_LOG
    else
        echo "Skipping ${repo}..."
    fi
done

echo "Sorting combined log..."
cat $COMBINED_LOG | sort -n > $SORTED_LOG
rm $COMBINED_LOG

head -n10 $SORTED_LOG
echo '...'
tail -n10 $SORTED_LOG

echo "======================"
echo "Committers:"
cat $SORTED_LOG | awk -F\| {'print  $2'} | sort | uniq
echo "======================"

# todo: flag to make ffmpeg optional
time gource $SORTED_LOG \
    -$RESOLUTION \
    --colour-images \
    --file-idle-time 0 \
    --hide dirnames,progress,filenames \
    --highlight-users \
    --key \
    --max-file-lag 0.1 \
    --max-files 0 \
    --seconds-per-day 0.1 \
    --user-scale 3 \
    -r 60 \
    -o - | ffmpeg -y -r 60 -f image2pipe -vcodec ppm -i - -vcodec libvpx -b 10000K $OUTFILE

rm $SORTED_LOG
