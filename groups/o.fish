
# Yes, I know xdg-open, but it's a pain to configure :-(
#
# For now, this.
#
function o

  if test (string match -r '\.scad$' $argv[1])
    openscad $argv
  else
    open $argv
  end
end

