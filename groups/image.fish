
# image

function iid

  identify -verbose $argv | less
end

function ires

  # array indices start at 1, not 0  ;-)

  convert $argv[1] -resize 256x256 resized_$argv[1]
end

