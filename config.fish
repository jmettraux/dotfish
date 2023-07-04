
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
  #bind -k \sleft backward-char

  bind -M insert \cj history-search-backward

  # By default TAB does "complete"...
  #
  bind -M insert \cl forward-char
  #bind -M insert \c] forward-char
  bind -M insert \t forward-char
  bind -M insert \s\t complete
end

set -x PATH ~/bin $PATH
set -x MANPAGER less


set fish_function_path ~/.fish/functions $fish_function_path

for pa in ~/.fish/groups/*.fish
  source $pa
end
for pa in ~/.fish/locals/*.fish
  source $pa
end

