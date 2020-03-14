
function skeygen

  set fname $argv[1]

  ssh-keygen -t ed25519 -a 100 -f $fname -C "jmettraux+$fname@gmail.com"
end

