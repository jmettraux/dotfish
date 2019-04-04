
function fish_right_prompt

  if test "$fish_key_bindings" = "fish_vi_key_bindings"
      or test "$fish_key_bindings" = "fish_hybrid_key_bindings"

    set_color --bold 191919

    switch $fish_bind_mode
    case default
      printf '令'
    case insert
      printf '入'
    case replace_one
      printf '換'
    case visual
      printf '視'
    end
    set_color normal
  end
end

