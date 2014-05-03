# aliases and functions
# Shows most used commands, cool script I got this from: http://lifehacker.com/software/how-to/turbocharge-your-terminal
alias profileme="history | awk '{print \$2}' | awk 'BEGIN{FS=\"|\"}{print \$1}' | sort | uniq -c | sort -n | tail -n 20 | sort -nr"

if shell_is_osx; then
    # Get rid of those pesky .DS_Store files recursively
    alias dsstore-clean='find . -type f -name .DS_Store -print0 | xargs -0 rm'

    alias flushdns='dscacheutil -flushcache'

    alias ls='ls -hF'
elif shell_is_linux; then
    alias ls='ls -hF --color'
fi

# mkdir and cd there
mkcd() { [ -n "$1" ] && mkdir -p "$@" && cd "$1"; }

alias bs8="flake8 --max-line-length=250"
