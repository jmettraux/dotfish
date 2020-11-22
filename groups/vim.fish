
function v
  vim $argv
end
function vi
  vim $argv
end
function :e
  vim $argv
end

function vf
  vim (find . -name "*$argv[1]*" | head -1)
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

function vT
  vim -c "call feedkeys(\";t\")" # open .todo.md
end
function vtd
  vim -c "call feedkeys(\";t\")" # open .todo.md
end

function vp
  vim -c "OpenPrevious"
end

function vs # vi source
  if test -d src/
    vt src/
  else if test -d lib/
    vt lib/
  else
    vt ./
  end
end

function vc # vi spec
  if test -d spec/
    vt spec/
  else if test -d test/
    vt test/
  else
    vt ./
  end
end

function vg
  # TODO investigate why :Vg doesn't add the dot :-(
  if test (count $argv) -eq 1
    vim -c ":Vg \"$argv[1]\" ."
  else
    vim -c ":Vg \"$argv[1]\" $argv[2..-1]"
  end
end
function Vg
  vg $argv
end

