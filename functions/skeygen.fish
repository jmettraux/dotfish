
function skeygen

  set fname $argv[1]

  if test "$fname" = ""; echo "USAGE: skeygen {fname}"; return 1; end

  ssh-keygen -t ed25519 -a 100 -f $fname -C "jmettraux+$fname@gmail.com"
end

