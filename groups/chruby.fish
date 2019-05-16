
# $ chruby            # change ruby to .ruby-version
# $ chruby list       # list rubies in ~/.rubies
# $ chruby jruby-9.2  # change to jruby-9.2*
# $ chruby ruby 2.3   # change to ruby-2.3*
#
function chruby

  set -l RUBIES (realpath ~/.rubies)
  set -l GEMS (realpath ~/.gem)

  if test "$argv" = "list"
    for r in $RUBIES/*; echo (basename $r); end
    return 0
  end

  set -q FISH_NO_CHRUBY; if test $status = 0; return 0; end

  # clear, change ruby

  set -l as $argv
  if test (count $argv) = 0
    if test -f .ruby-version
      set as (cat .ruby-version)
    else
      return 0
    end
  end
  set as (string join '-' $as)
    #
  set -l rubyver (ls $RUBIES | grep $as | head -1)
    #
  if test "$rubyver" = ""; echo "no ruby >$as< found"; return 1; end

  set -l rubyev (string split "-" -- $rubyver)

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

  set -gx RUBY_ROOT $RUBIES/$rubyver
  set -gx GEM_HOME $GEMS/$RUBY_ENGINE/$c_ruby_version
  set -gx GEM_ROOT $RUBY_ROOT/lib/ruby/gems/(ls $RUBY_ROOT/lib/ruby/gems)[1]
  set -gx GEM_PATH $GEM_HOME:$GEM_ROOT
  #echo "\$RUBY_ROOT: $RUBY_ROOT"
  #echo "\$GEM_HOME: $GEM_HOME"
  #echo "\$GEM_ROOT: $GEM_ROOT"
  #echo "\$GEM_PATH: $GEM_PATH"

  set -l rl (string length $RUBIES)
  set -l gl (string length $GEMS)
  set -l path
    #
  for pa in $PATH
    set pa (realpath $pa)
    if test (string sub -l $rl $pa) = $RUBIES; continue; end
    if test (string sub -l $gl $pa) = $GEMS; continue; end
    if contains $pa $path; continue; end
    set path $path $pa
  end
    #
  set -gx PATH $GEM_HOME/bin $GEM_ROOT/bin $RUBY_ROOT/bin $path
  #echo "\$PATH: $PATH"

  if test "$FISH_CHRUBY_SILENT" = ""
    echo "ruby set to $RUBY_ROOT"
  end
end


# each time the variable PWD changes on value, call chruby...
#
function l --on-variable PWD

  chruby
end

