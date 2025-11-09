
function autorun --on-variable PWD

  if not string match -q "$(realpath ~/w/)*" (pwd)
    return
  end

  if test -e .autoenv.fish
    source .autoenv.fish
    echo -e "\033[32msourced"
    echo -e "  .autoenv.fish\033[0m"
  end
end

