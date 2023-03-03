
# mpv.fish


function play

  doas /usr/sbin/rcctl restart sndiod

  if string match -r '\.txt$' $argv[1]
    mpv --no-video --playlist=$argv
  else
    mpv --no-video $argv
  end
end

