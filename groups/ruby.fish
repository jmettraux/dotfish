
# chruby, thanks to https://github.com/JeanMertz/chruby-fish

source /usr/local/share/chruby/chruby.fish
source /usr/local/share/chruby/auto.fish


# ruby

function rv
  ruby -v
end
function wr
  which ruby
end

function bx
  bundle exec $argv
end

function bxr
  bundle exec ruby $argv
end

#alias bxsdr="bundle exec rspec --dry-run"

