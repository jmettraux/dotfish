
# java

if test -d /usr/local/jdk-17/bin
  set -x PATH /usr/local/jdk-17/bin $PATH
else if test -d /usr/local/jdk-11/bin
  set -x PATH /usr/local/jdk-11/bin $PATH
end

