
# feh

function fe
  feh -d -F --info "echo '%F %s %S %hx%w %z'" $argv
end
function fe0
  feh -d --info "echo '%F %s %S %hx%w %z'" $argv
end

function feg
  feh \
    -d -F --borderless --image-bg lightgrey \
    --info "echo '%F %s %S %hx%w %z'" $argv
end

function qfe
  qrencode $argv -o - | feh -d -F -
end

