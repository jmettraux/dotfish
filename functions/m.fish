
function m
  switch (uname)
  case OpenBSD
    gmake $argv
  case '*'
    make $argv
  end
end

