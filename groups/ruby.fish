
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
  if string match -q '*jruby*' (which ruby)
    jruby -J-Xms1024m -J-Xmx1024m -S bundle exec proba $argv
  else
    bundle exec proba $argv
  end
end

#alias bxsdr="bundle exec rspec --dry-run"

