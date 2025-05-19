
function autorun --on-variable PWD

  if not string match -q "$(realpath ~/w/)*" (pwd)
    return
  end

  if test -e .autoenv.fish
    source .autoenv.fish
  end
end

