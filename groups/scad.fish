
# groups/scad.fish

function stlv

  set -l fname "_tmp_stl_v.scad"

  echo -n 'import("' > $fname
  echo -n $argv[1] >> $fname
  echo '");' >> $fname

  openscad $fname
end

