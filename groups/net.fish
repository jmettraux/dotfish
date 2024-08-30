
# net functions

function nstat
  netstat -rn
end
function nistat
  netstat -i
end

function routes
  echo; echo "##  arp -a  -->"
  arp -a
  echo; echo "##  route -n show -inet  -->"
  route -n show -inet
end

function renet
  doas sh /etc/netstart $argv
end
