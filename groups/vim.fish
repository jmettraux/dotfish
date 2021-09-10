
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

function vss

  set paths lib out

  set n (basename (pwd))
  set fa (find $paths -name "$n.css" | head -1)
  set fb (find $paths -name "style.css" | head -1)
  set fc (find $paths -name "*.css" | head -1)

  if test -n "$fa"; vim $fa
  else if test -n "$fb"; vim $fb
  else if test -n "$fc"; vim $fc
  end
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
  if test -d src/; vt src/
  else if test -d lib/; vt lib/
  else; vt ./
  end
end

function vc # vi spec
  if test -d spec/; vt spec/
  else if test -d test/; vt test/
  else if test -d src/; vt src/
  else; vt ./
  end
end

function vv # vi content
  if test -d posts/; vt posts/
  else if test -d src/; vt src/
  else if test -d lib/; vt lib/
  else if test -d scripts/; vt scripts/
  else; vt ./
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

function vj
  #vt scripts/
  vim -c "call feedkeys(\";j\")" # scripts/ js/ or src/
end

function va
  if test -d app/views/; vt app/views/
  else if test -d app/; vt app/
  else; vt ./
  end
end

