
function v
  vim $argv
end
function vi
  vim $argv
end
function :e
  vim $argv
end

function vic
  vim -c 'execute "silent !echo " . &fileencoding | q' $argv
end

function vb
  vim -c "ListFiles" # list buffers and all
end
function vd
  vim -c "call feedkeys(\";d\")" # open git diff
end
function vl
  vim -c "call feedkeys(\";l\")" # open git log
end

function vt
  if test (count $argv) -lt 1
    vim -c ":Vt ."
  else
    vim -c ":Vt $argv"
  end
end

