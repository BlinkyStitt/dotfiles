SSH_ENV="$HOME/.ssh/environment"

# todo: check for ssh-agent in /opt
SSH_AGENT_BIN="/usr/bin/ssh-agent"
SSH_ADD_BIN="/usr/bin/ssh-add"

function start_agent {
     echo "Initialising new SSH agent..."
     $SSH_AGENT_BIN | sed 's/^echo/#echo/' > "${SSH_ENV}"
     chmod 600 "${SSH_ENV}"
     . "${SSH_ENV}" > /dev/null
     $SSH_ADD_BIN;
}

# Source SSH settings, if applicable

if [ -f "${SSH_ENV}" ]; then
     . "${SSH_ENV}" > /dev/null
     #ps ${SSH_AGENT_PID} doesn't work under cywgin
     ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
         start_agent;
     }
else
     start_agent;
fi

