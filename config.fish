
fish_vi_key_bindings
set -gx EDITOR vim

#bind -M insert -k right forward-char # right-arrow
bind -M insert ] forward-char

set -x PATH ~/bin $PATH


set fish_function_path ~/.fish/functions $fish_function_path

for pa in ~/.fish/groups/*.fish
  source $pa
end
for pa in ~/.fish/locals/*.fish
  source $pa
end

