# if [[ -e "$HOME/.gnupg/.override-ssh-agent" ]]; then
#     envfile="$HOME/.gnupg/gpg-agent.env"
#     if [[ -e "$envfile" ]] && kill -0 $(grep GPG_AGENT_INFO "$envfile" | cut -d: -f 2) 2>/dev/null; then
#         eval "$(cat "$envfile")"
#     else
#         eval "$(gpg-agent --daemon --enable-ssh-support --write-env-file "$envfile")"
#     fi
#     export GPG_AGENT_INFO
#     export SSH_AUTH_SOCK
# fi
