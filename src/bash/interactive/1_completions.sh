# run completions last since they may need config variables

for i in ~/.bash/completions/*.sh ; do
    if [ -r "$i" ]; then
        if [ "$PS1" ]; then
            . $i
        else
            . $i >/dev/null 2>&1
        fi
    fi
done

if command_exists brew; then
  if [ -r `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
  fi
else
  if [ -f /usr/local/share/bash-completion/bash_completion.sh ]; then
    . /usr/local/share/bash-completion/bash_completion.sh
  fi
fi
