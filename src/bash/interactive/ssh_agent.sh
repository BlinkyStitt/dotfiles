SSH_ENV="$HOME/.ssh/environment"

# this could be a dangerous, use explicit checks instead
: '
if command_exists ssh-agent; then
   source `which ssh-agent`
fi
if command_exists ssh-add; then
   source `which ssh-add`
fi
'

# check in /usr/bin (for most all systems), then /opt/bin (for qnap)
if [ -x "/usr/bin/ssh-agent" ]; then
     SSH_AGENT_BIN="/usr/bin/ssh-agent"
elif [ -x "/opt/bin/ssh-agent" ]; then
     SSH_AGENT_BIN="/opt/bin/ssh-agent"
fi
if [ -x "/usr/bin/ssh-add" ]; then
     SSH_ADD_BIN="/usr/bin/ssh-add"
elif [ -x "/opt/bin/ssh-add" ]; then
     SSH_ADD_BIN="/opt/bin/ssh-add"
fi

function start_agent {
     echo "Initialising new SSH agent..."
     # make sure our environment file exists with the proper permissions
     if [ ! -e ${SSH_ENV} ]; then
          touch "${SSH_ENV}"
     fi
     chmod 600 "${SSH_ENV}"

     # save agent's output into a file for later
     $SSH_AGENT_BIN | sed 's/^echo/#echo/' > "${SSH_ENV}"

     # attach to the ssh agent
     . "${SSH_ENV}" > /dev/null

     # add the default key (~/.ssh/id_rsa)
     # I don't always want ssh-add autorun, so comment this out
     # $SSH_ADD_BIN;
}

# only do this if we have ssh-agent and ssh-add
if [[ -n $SSH_AGENT_BIN && -n $SSH_ADD_BIN ]]; then
     if [ -f "${SSH_ENV}" ]; then
          . "${SSH_ENV}" > /dev/null
          #ps ${SSH_AGENT_PID} doesn't work under cywgin
          # todo: qnap's grep doesn't understand the $ :(
          HAS_AGENT=`ps -ef | grep ${SSH_AGENT_PID} | grep "ssh-agent$"`
          if [ -n "${HAS_AGENT}" ]; then
               echo 'Connected to existing SSH agent.'
          else
               start_agent
          fi
     else
          start_agent
     fi
fi
