
function fish_right_prompt

  if test "$fish_key_bindings" = "fish_vi_key_bindings"
      or test "$fish_key_bindings" = "fish_hybrid_key_bindings"

    set_color --bold 191919

    switch $fish_bind_mode
    case default
      printf '[N]'
    case insert
      printf '[I]'
    case replace_one
      printf '[r]'
    case visual
      printf '[v]'
    end
    set_color normal
  end
end

