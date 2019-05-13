
function chruby

  set -q FISH_NO_CRUBY; if test $status = 0; return; end
  if test ! -e .ruby-version; return; end

  set -l rubyver (ls ~/.rubies/ | grep (cat .ruby-version))
  set -l rubyev (string split "-" -- $rubyver)
  #echo $rubyver
  #echo $rubyev

  set -gx RUBY_ENGINE $rubyev[1]
  set -gx RUBY_VERSION $rubyev[2]
  #echo "\$RUBY_ENGINE: $RUBY_ENGINE"
  #echo "\$RUBY_VERSION: $RUBY_VERSION"

  set -gx RUBY_ROOT ~/.rubies/$rubyver
  set -gx GEM_HOME ~/.gem/ruby/$RUBY_VERSION
  set -gx GEM_ROOT $RUBY_ROOT/lib/ruby/gems/(ls $RUBY_ROOT/lib/ruby/gems)[1]
  set -gx GEM_PATH $GEM_HOME:$GEM_ROOT
  #echo "\$RUBY_ROOT: $RUBY_ROOT"
  #echo "\$GEM_HOME: $GEM_HOME"
  #echo "\$GEM_ROOT: $GEM_ROOT"
  #echo "\$GEM_PATH: $GEM_PATH"

  set -gx PATH $GEM_HOME/bin:$GEM_ROOT/bin:$RUBY_ROOT/bin:$PATH
  #echo "\$PATH: $PATH"

  echo "ruby set to $RUBY_ROOT"
end


function l --on-variable PWD

  chruby
end

