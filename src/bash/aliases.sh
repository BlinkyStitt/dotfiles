# Shows most used commands, cool script I got this from: http://lifehacker.com/software/how-to/turbocharge-your-terminal
alias profileme="history | awk '{print \$2}' | awk 'BEGIN{FS=\"|\"}{print \$1}' | sort | uniq -c | sort -n | tail -n 20 | sort -nr"

# easy ssh to the ASUCD subnet
# 'asucd 123 -l user' -> 'ssh 169.237.101.123 -l user'
function asucd () {
  local var="ssh 169.237.101.$*"
  echo $var
  $var;
}

# ls
alias ls='ls -hF'
