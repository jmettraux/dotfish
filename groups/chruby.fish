
set -gx _RUBIES (realpath ~/.rubies)
set -gx _GEMS (realpath ~/.gem)


function chruby

  if test "$argv" = "list"; chruby_list; return; end

  set -q FISH_NO_CRUBY; if test $status = 0; return; end
  if test ! -e .ruby-version; return; end

  # clear, change ruby

  set -l as $argv
  if test (count $argv) = 0; set as (cat .ruby-version); end
    #
  set -l rubyver (ls $_RUBIES | grep (string join '-' $argv) | head -1)

  set -l rubyev (string split "-" -- $rubyver)
  #echo $rubyver
  #echo $rubyev

  set -gx RUBY_ENGINE $rubyev[1]
  set -gx RUBY_VERSION $rubyev[2]
  #echo "\$RUBY_ENGINE: $RUBY_ENGINE"
  #echo "\$RUBY_VERSION: $RUBY_VERSION"

  set -l c_ruby_version $RUBY_VERSION
    #
  if test $RUBY_ENGINE = 'jruby'
    set c_ruby_version \
      (string join "." \
        (string split "." -- $RUBY_VERSION)[2..-1])
  end

  set -gx RUBY_ROOT $_RUBIES/$rubyver
  set -gx GEM_HOME $_GEMS/$RUBY_ENGINE/$c_ruby_version
  set -gx GEM_ROOT $RUBY_ROOT/lib/ruby/gems/(ls $RUBY_ROOT/lib/ruby/gems)[1]
  set -gx GEM_PATH $GEM_HOME:$GEM_ROOT
  #echo "\$RUBY_ROOT: $RUBY_ROOT"
  #echo "\$GEM_HOME: $GEM_HOME"
  #echo "\$GEM_ROOT: $GEM_ROOT"
  #echo "\$GEM_PATH: $GEM_PATH"

  set -l rl (string length $_RUBIES)
  set -l gl (string length $_GEMS)
  set -l path
    #
  for pa in $PATH
    set pa (realpath $pa)
    if test (string sub -l $rl $pa) = $_RUBIES; continue; end
    if test (string sub -l $gl $pa) = $_GEMS; continue; end
    if contains $pa $path; continue; end
    set path $path $pa
  end
    #
  set -gx PATH $GEM_HOME/bin $GEM_ROOT/bin $RUBY_ROOT/bin $path
  #echo "\$PATH: $PATH"

  echo "ruby set to $RUBY_ROOT"
end

function chruby_list

  for r in $_RUBIES/*; echo (basename $r); end
end


function l --on-variable PWD

  chruby
end

