
function chruby

  set -q FISH_NO_CRUBY; if test $status = 0; return; end
  if test ! -e .ruby-version; return; end

  # clear, change ruby

  set -l rubydir (realpath ~/.rubies)
  set -l gemdir (realpath ~/.gem)

  set -l rubyver (ls $rubydir | grep (cat .ruby-version))
  set -l rubyev (string split "-" -- $rubyver)
  #echo $rubyver
  #echo $rubyev

  set -gx RUBY_ENGINE $rubyev[1]
  set -gx RUBY_VERSION $rubyev[2]
  echo "\$RUBY_ENGINE: $RUBY_ENGINE"
  echo "\$RUBY_VERSION: $RUBY_VERSION"

  set -l c_ruby_version $RUBY_VERSION
    #
  if test $RUBY_ENGINE = 'jruby'
    set c_ruby_version \
      (string join "." \
        (string split "." -- $RUBY_VERSION)[2..-1])
  end

  set -gx RUBY_ROOT $rubydir/$rubyver
  set -gx GEM_HOME $gemdir/$RUBY_ENGINE/$c_ruby_version
  set -gx GEM_ROOT $RUBY_ROOT/lib/ruby/gems/(ls $RUBY_ROOT/lib/ruby/gems)[1]
  set -gx GEM_PATH $GEM_HOME:$GEM_ROOT
  #echo "\$RUBY_ROOT: $RUBY_ROOT"
  #echo "\$GEM_HOME: $GEM_HOME"
  #echo "\$GEM_ROOT: $GEM_ROOT"
  #echo "\$GEM_PATH: $GEM_PATH"

  set -l rl (string length $rubydir)
  set -l gl (string length $gemdir)
  set -l path
    #
  for pa in $PATH
    set pa (realpath $pa)
    if test (string sub -l $rl $pa) = $rubydir; continue; end
    if test (string sub -l $gl $pa) = $gemdir; continue; end
    if contains $pa $path; continue; end
    set path $path $pa
  end
    #
  set -gx PATH $GEM_HOME/bin $GEM_ROOT/bin $RUBY_ROOT/bin $path
  #echo "\$PATH: $PATH"

  echo "ruby set to $RUBY_ROOT"
end


function l --on-variable PWD

  chruby
end

