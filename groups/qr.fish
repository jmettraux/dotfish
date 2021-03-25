
# thanks to
#   https://dataswamp.org/~solene/2021-03-25-computer-to-phone-text.html

function qrim
  qrencode -o - -t PNG | feh -g 600x600 -Z -
end

