
#
# groups/java.fish

#if test -d /usr/local/jdk-17/bin
#  set -x PATH /usr/local/jdk-17/bin $PATH
#else if test -d /usr/local/jdk-11/bin
#  set -x PATH /usr/local/jdk-11/bin $PATH
#end

for dir in (ls -d /usr/local/jdk-* | sort -rV)

  if test -d $dir

    set -x PATH $dir/bin $PATH
    break
  end
end
