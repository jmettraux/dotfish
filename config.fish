
set -gx EDITOR vim

set fish_function_path ~/.fish/functions $fish_function_path

for pa in ~/.fish/groups/*.fish
  source $pa
end
for pa in ~/.fish/locals/*.fish
  source $pa
end

