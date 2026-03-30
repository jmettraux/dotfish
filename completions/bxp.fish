
#
# Fish completions for probatio
#
# place in ~/.fish/completions/
#

set OUTF .probatio-output.rb

function __bxp_paths_completion

  if test -f $OUTF
    for l in (string trim -- < $OUTF)
      set -l m (string match -gr ' p: "([^"]+)", l: (\d+), t:' -- $l)
      if test -n "$m"
        echo "$m[1]:$m[2]"
      end
    end
  end
end

complete -c bxp -a '(__bxp_paths_completion)'
complete -c bxp -a "(__fish_complete_path)"

