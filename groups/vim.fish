
function v
  vim
end
function vi
  vim
end
function :e
  vim
end

function vic
  vim -c 'execute "silent !echo " . &fileencoding | q'
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

