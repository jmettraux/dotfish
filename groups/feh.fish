
# feh

function fe
  feh -d -F $argv
end

function qfe
  qrencode $argv -o - | feh -d -F -
end

