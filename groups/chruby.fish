
# $ chruby            # change ruby to .ruby-version
# $ chruby list       # list rubies in ~/.rubies
# $ chruby current    # list current RUBY settings
# $ chruby jruby-9.2  # change to jruby-9.2*
# $ chruby ruby 2.3   # change to ruby-2.3*
# $ chruby 2.3        # change to [j]ruby-2.3*
#
function chruby

  if test "$argv" = "list"; __chruby_list; return 0; end
  if test "$argv" = "current"; __chruby_current; return 0; end

  set -q FISH_NO_CHRUBY; if test $status = 0; return 0; end

  __chruby_clean_vars
  __chruby_clean_path

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

  set -l x
  for r in (__chruby_list)
    set x $(string match "*$as*" $r)
    if test "$x" != ""; break; end
  end
  set as (string split ' ' $x)[1]

  set -l rubyver (ls (realpath ~/.rubies) | grep $as | head -1)
    #
  if test "$rubyver" != ""
    __chruby_dot_set $rubyver
    return 0
  end

  set -l rubyver (ls /usr/local/bin/ | grep ruby | grep $as | head -1)
    #
  if test "$rubyver" != ""
    __chruby_pkg_set $rubyver
    return 0
  end

  echo "no ruby >$as< found"
  return 1
end


# each time the variable PWD changes on value, call chruby...
#
function l --on-variable PWD

  chruby
end


function __chruby_list

  for r in (realpath ~/.rubies)/*
    if test -e $r/bin/ruby
      echo (basename $r) '-->' (string replace -r ' on .+' '' ($r/bin/ruby --version))
    end
  end

  for r in /usr/local/bin/ruby*
    set -l rr (basename $r)
    if test -z (string match -r '^ruby[0-9]+$' $rr)
    else
      echo $rr '-->' ($r --version)
    end
  end
end

function __chruby_current

  echo "--- VARIABLES"

  echo "\$RUBY_ENGINE: $RUBY_ENGINE"
  echo "\$RUBY_VERSION: $RUBY_VERSION"

  echo "\$RUBIES: $RUBIES"
  echo "\$RUBY_ROOT: $RUBY_ROOT"
  echo "\$GEM_HOME: $GEM_HOME"
  echo "\$GEM_ROOT: $GEM_ROOT"
  echo "\$GEM_PATH: $GEM_PATH"

  echo "\$PATH: $PATH"

  echo "--- ruby --version"
  which ruby
  ruby --version

  echo "--- gem --version"
  which gem
  gem --version

  echo "--- bundle --version"
  which bundle
  bundle --version
end

function __chruby_dot_set

  set -l rubyver (string replace -r '/' '' $argv[1])

  set -l RUBIES (realpath ~/.rubies)
  set -l GEMS (realpath ~/.gem)

  set -l rubyev (string split "-" -- $rubyver)

  set -gx RUBY_ENGINE $rubyev[1]
  set -gx RUBY_VERSION $rubyev[2]

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

  set -gx PATH $GEM_HOME/bin $GEM_ROOT/bin $RUBY_ROOT/bin $PATH

  if test "$FISH_CHRUBY_SILENT" = ""
    #echo "ruby set to $RUBY_ROOT"
    echo "ruby set to"
    echo "  $(which ruby)"
    echo "  $(ruby --version)"
  end
end

function __chruby_clean_vars

  set -e RUBY_ENGINE
  set -e RUBY_VERSION

  set -e RUBY_ROOT
  set -e GEM_HOME
  set -e GEM_ROOT
  set -e GEM_PATH
end

function __chruby_clean_path

  set -l RUBIES (realpath ~/.rubies)
  set -l GEMS (realpath ~/.gem)

  set -l rl (string length $RUBIES)
  set -l gl (string length $GEMS)
  set -l path
    #
  for pa in $PATH
    #set pa (realpath $pa)
    if test -z $pa; continue; end
    if test (string sub -l $rl $pa) = $RUBIES; continue; end
    if test (string sub -l $gl $pa) = $GEMS; continue; end
    if contains $pa $path; continue; end
    set path $path $pa
  end

  set -gx PATH $GEM_HOME/bin $GEM_ROOT/bin $RUBY_ROOT/bin $path
end

function __chruby_pkg_set

  set -l rubyver (string replace -r '\*' '' $argv[1])
  set -l v (string match -r '\d+' $rubyver)

  alias ruby="/usr/local/bin/$rubyver"
  alias gem="/usr/local/bin/gem$v"
  alias bundle="/usr/local/bin/bundle$v"

  set -l GEMS (realpath ~/.gem)

  set -l gempath (ruby -e 'puts Gem.path' | grep "$GEMS")
  #echo "gempath:>$gempath<"

  mkdir -p $gempath
  mkdir -p $gempath/cache

  set -gx GEM_HOME $gempath

  if test "$FISH_CHRUBY_SILENT" = ""
    echo "ruby set to"
    echo "  /usr/local/bin/$rubyver"
    echo "  $(ruby --version)"
  end
end

