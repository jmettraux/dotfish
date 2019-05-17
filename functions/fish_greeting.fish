
function fish_greeting

  #set -l c_lightgrey (set_color A9A9A9)

  echo (set_color A9A9A9)
  if type -q fortune
    fortune -a
  else if type -q /usr/games/fortune
    /usr/games/fortune -a
  end

  echo (set_color 292929)
  uname -a

  echo (set_color normal)
end

