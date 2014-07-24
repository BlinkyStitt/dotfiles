#!/usr/bin/env bash
# Generates gource video (h.264) out of multiple repositories.
# Pass the repositories in command line arguments.
# Example:
# <this.sh> /path/to/repo1 /path/to/repo2

RESOLUTION="1600x1080"
outfile="gource.mp4"

i=0
for repo in $*; do
    # 1. Generate a Gource custom log files for each repo. This can be facilitated by the --output-custom-log FILE option of Gource as of 0.29:
    logfile="$(mktemp /tmp/gource.XXXXXX)"
    gource --output-custom-log "${logfile}" ${repo}
    # 2. If you want each repo to appear on a separate branch instead of merged onto each other (which might also look interesting), you can use a 'sed' regular expression to add an extra parent directory to the path of the files in each project:
    sed -i -E "s#(.+)\|#\1|/${repo}#" ${logfile}
    logs[$i]=$logfile
    let i=$i+1
done

combined_log="$(mktemp /tmp/gource.XXXXXX)"
cat ${logs[@]} | sort -n > $combined_log
rm ${logs[@]}

echo "Committers:"
cat $combined_log | awk -F\| {'print  $2'} | sort | uniq
echo "======================"

# todo: flag for ffmpeg
time gource $combined_log \
    -$RESOLUTION \
    --colour-images \
    --file-extensions \
    --file-filter node_modules \
    --hide progress \
    --highlight-users \
    --key \
    --stop-at-end

rm $combined_log
