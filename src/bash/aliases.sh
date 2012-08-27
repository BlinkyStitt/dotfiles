# Shows most used commands, cool script I got this from: http://lifehacker.com/software/how-to/turbocharge-your-terminal
alias profileme="history | awk '{print \$2}' | awk 'BEGIN{FS=\"|\"}{print \$1}' | sort | uniq -c | sort -n | tail -n 20 | sort -nr"

alias ls='ls -hF'

if shell_is_osx; then
    # Get rid of those pesky .DS_Store files recursively
    alias dsstore-clean='find . -type f -name .DS_Store -print0 | xargs -0 rm'

    alias flushdns='dscacheutil -flushcache'
fi
