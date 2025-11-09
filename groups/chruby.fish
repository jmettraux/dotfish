
# $ chruby            # change ruby to .ruby-version
# $ chruby list       # list rubies in ~/.rubies
# $ chruby current    # list current RUBY settings
# $ chruby jruby-9.2  # change to jruby-9.2*
# $ chruby ruby 2.3   # change to ruby-2.3*
# $ chruby 2.3        # change to [j]ruby-2.3*
#
function chruby

  mkdir -p ~/.rubies
  mkdir -p ~/.gem

  if test "$argv" = "list"; __chruby_list; return 0; end
  if test "$argv" = "current"; __chruby_current; return 0; end

  set -q FISH_NO_CHRUBY; if test $status = 0; return 0; end

  __chruby_clean_vars
  __chruby_clean_path

  # clear, change ruby

  set -l as $argv
  if test (count $argv) = 0
    if test -f .ruby-version
      set -l m (string match -r '^\s*(.+)[ -]+(.+)\s*$' (cat .ruby-version))
      set as $m[2] $m[3]
    else
      return 0
    end
  end

  set -l r0 (string join '-' $as)
  set -l r1 (string join ' ' $as)

  set -l x
  for r in (__chruby_list)

    set x $(string match "*$r0*" $r)
    if test "$x" != ""; break; end

    set x $(string match "*$r1*" $r)
    if test "$x" != ""; break; end
  end
  set -l r (string split ' --> ' $x)[1]
  set -l p (string split '/' $r)[2]

  if test "$p" = "home"
    __chruby_dot_set $r
    return 0
  end

  if test "$p" = "usr"
    __chruby_pkg_set $r
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

    # link bin/ruby -> bin/jruby if necessary
    #
    if ! test -e $r/bin/ruby; and test -e $r/bin/jruby
      ln -s $r/bin/jruby $r/bin/ruby
    end

    if test -e $r/bin/ruby
      echo "$r/bin/ruby -->" (string replace -r ' on .+' '' ($r/bin/ruby --version))
    end
  end

  for r in /usr/local/bin/ruby*
    if test -z (string match -r '^ruby[0-9]+$' (basename $r))
    else
      echo $r '-->' ($r --version)
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

function __chruby_dot_set

  set -l rubyver (string split '/' $argv[1])[5]
  #echo ">$rubyver<"

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
    #echo -e "\033[1;31mruby set to"
    echo -e "\033[38;2;219;27;27mruby set to"
    echo -e "  $(which ruby)"
    echo -e "  $(ruby --version)\033[0m"
  end
end

function __chruby_pkg_set

  set -l rubyver (string replace -r '\*' '' $argv[1])
  set -l v (string match -r '\d+' $rubyver)

  #alias ruby="/usr/local/bin/$rubyver"
  #alias gem="/usr/local/bin/gem$v"
  #alias bundle="/usr/local/bin/bundle$v"
    #
    # no, because it doesn't work in Makefile and subshells...

  set -l path ~/.pkg_rubies/ruby$v
  mkdir -p $path
    #
  if ! test -e $path/ruby
    ln -s /usr/local/bin/ruby$v $path/ruby
    ln -s /usr/local/bin/gem$v $path/gem
    ln -s /usr/local/bin/bundle$v $path/bundle
  end

  set -l GEMS (realpath ~/.gem)

  set -l gempath ($path/ruby -e 'puts Gem.path' | grep "$GEMS")
  #echo "gempath:>$gempath<"

  mkdir -p $gempath
  mkdir -p $gempath/cache

  set -gx GEM_HOME $gempath

  set -gx PATH $path $PATH

  if test "$FISH_CHRUBY_SILENT" = ""
    #echo -e "\033[31mruby set to"
    echo -e "\033[38;2;219;27;27mruby set to"
    echo -e "  /usr/local/bin/$rubyver"
    echo -e "  $(ruby --version)\033[0m"
  end
end

