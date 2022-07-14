
# doas pkg_add colorls
#
# :-)

#export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD
#export LSCOLORS=exfxfeaeBxxehehbadacea
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx


function ll
  if test -e /usr/local/bin/colorls
    colorls -Gal $argv
  else
    ls -al $argv
  end
end
function llh
  if test -e /usr/local/bin/colorls
    colorls -Galh $argv
  else
    ls -alh $argv
  end
end
alias lh=llh

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

