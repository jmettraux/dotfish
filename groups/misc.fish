
# mkdir and cd

function mkncd

  mkdir -p $argv
  cd $argv
end

function kaal

  cal -mw $argv | \
    perl -pe 's/\[(\d+)\]/  w$1/' | \
    perl -pe 's/Su/Su\n/' | \
    perl -pe 's/Mo/\nMo/'
end

function kal

  cal -mw $argv | \
    perl -pe 's/\[(\d+)\]/  w$1/'
end

