
function fish_prompt

  set -l last_status $status
  set -l c_normal (set_color normal)
  set -l c_lightgrey (set_color A9A9A9)
  set -l c_grey (set_color 595959)
  set -l c_darkgrey (set_color 191919)
  set -l c_darkgreen (set_color 009900)

  set -l user
  set -l color_cwd
  set -l prefix
  set -l suffix

  switch "$USER"
  case root toor
    if set -q fish_color_cwd_root
      set color_cwd $fish_color_cwd_root
    else
      set color_cwd $fish_color_cwd
    end
    set user '車'
    set suffix ' #'
  case jmettraux
    set user '我'
    set suffix ' >'
  case '*'
    set color_cwd $fish_color_cwd
    set suffix '>'
  end

  set -l os (uname)
  switch $os
  case Darwin
    set os 'ダ'
  case OpenBSD
    set os 'オ'
  case Linux
    set os 'リ'
  end

  set -l prompt_status
  if test $last_status -ne 0
    set prompt_status ' ' (set_color $fish_color_status) "[$last_status]" "$normal"
  end

  echo -n -s \
    $c_grey "$user" $c_darkgrey @ $c_lightgrey (prompt_hostname) ' ' \
    $c_grey $os $c_normal ' ' $c_darkgreen (prompt_pwd) \
    $c_normal (__fish_vcs_prompt) $c_normal $prompt_status $c_darkgrey $suffix ' '
end


# from https://mariuszs.github.io/blog/2013/informative_git_prompt.html

set -g __fish_git_prompt_show_informative_status 1
set -g __fish_git_prompt_hide_untrackedfiles 1

#set -g __fish_git_prompt_color_branch magenta bold
set -g __fish_git_prompt_color_branch FF9400
set -g __fish_git_prompt_showupstream "informative"
set -g __fish_git_prompt_char_upstream_ahead "↑"
set -g __fish_git_prompt_char_upstream_behind "↓"
set -g __fish_git_prompt_char_upstream_prefix ""

#set -g __fish_git_prompt_char_stagedstate "●"
#set -g __fish_git_prompt_char_dirtystate "✚"
set -g __fish_git_prompt_char_stagedstate "."
set -g __fish_git_prompt_char_dirtystate "+"
set -g __fish_git_prompt_char_conflictedstate "x"
set -g __fish_git_prompt_char_cleanstate "ok"
set -g __fish_git_prompt_char_untrackedfiles "…"

set -g __fish_git_prompt_color_dirtystate blue
set -g __fish_git_prompt_color_stagedstate yellow
set -g __fish_git_prompt_color_invalidstate red
set -g __fish_git_prompt_color_untrackedfiles $fish_color_normal
#set -g __fish_git_prompt_color_cleanstate green bold
set -g __fish_git_prompt_color_cleanstate green

