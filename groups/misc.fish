
# mkdir and cd

function mkncd

  mkdir -p $argv
  cd $argv
end

function kal

  cal -mw | perl -pe 's/\[(\d+)\]/  w$1/'
end

