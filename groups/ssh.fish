
# from https://gist.github.com/gerbsen/5fd8aa0fde87ac7a2cae

setenv SSH_ENV $HOME/.ssh/agent.fish.env

function start_agent
  echo "(ssh.fish) initializing new SSH agent..."
  ssh-agent -c | sed 's/^echo/#echo/' > $SSH_ENV
  echo "(ssh.fish) succeeded."
  chmod 600 $SSH_ENV
  . $SSH_ENV > /dev/null
  ssh-add
end

function test_identities
  ssh-add -l | grep "The agent has no identities" > /dev/null
  if [ $status -eq 0 ]
    ssh-add
    if [ $status -eq 2 ]
      start_agent
    end
  end
end

echo (set_color 292929)

if test -f "$SSH_CONNECTION"

  echo "(ssh.fish) connecting in ($SSH_CONNECTION), trusting agent forwarding."

else if test -n "$SSH_AGENT_PID"

  echo "(ssh.fish) agent already on and known ($SSH_AGENT_PID)..."

  ps aux | grep $SSH_AGENT_PID | grep ssh-agent > /dev/null
  if [ $status -eq 0 ]
    test_identities
  end

else

  echo "(ssh.fish) lock to already existing agent ($SSH_ENV)..."

  if test -f $SSH_ENV
    . $SSH_ENV > /dev/null
  end
  ps aux | grep $SSH_AGENT_PID | grep -v grep | grep ssh-agent > /dev/null
  if test $status -eq 0
    test_identities
  else
    echo "(ssh.fish) ouch, have to start an agent..."
    start_agent
  end
end

# use `set -e SSH_AGENT_PID` to unset

echo -n (set_color normal)

