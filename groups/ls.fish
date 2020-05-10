
function ll
  ls -al $argv
end
function lh
  ls -alh $argv
end

if test (uname) = 'OpenBSD'

  function t
    tree $argv
  end
  function ta
    tree -a $argv
  end
else

  function t
    tree -C $argv
  end
  function ta
    tree -Ca $argv
  end
  function th
    tree -Ch $argv
  end
  function tah
    tree -Cah $argv
  end
end

