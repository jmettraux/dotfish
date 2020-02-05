
if status is-interactive
  #
  # to avoid output like this when using rsync, wrap those bind calls
  # ---8<---
  # bind: No key with name 'right' found
  # bind: No key with name 'left' found
  # ...
  # --->8---

  fish_vi_key_bindings
  set -gx EDITOR vim

  #bind -M insert -k right forward-char # right-arrow
  #bind \cd delete-char

  #bind -M insert "]" forward-char
  bind -M insert "}" forward-char
end

set -x PATH ~/bin $PATH


set fish_function_path ~/.fish/functions $fish_function_path

for pa in ~/.fish/groups/*.fish
  source $pa
end
for pa in ~/.fish/locals/*.fish
  source $pa
end

