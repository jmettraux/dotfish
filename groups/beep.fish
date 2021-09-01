
function beep

  set count 1
  if test -n "$argv[1]"; set count (math 0 + $argv[1]); end

  for x in (seq $count)
    sleep 0.100
    aucat -i "$HOME/.fish/groups/beep.wav"
  end
end

