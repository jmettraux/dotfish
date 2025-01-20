
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

function bxp
  bundle exec proba $argv
end

#alias bxsdr="bundle exec rspec --dry-run"

