
#
# image.fish


function iid

  identify -verbose $argv | less
end

function ires

  # array indices start at 1, not 0  ;-)

  convert $argv[1] -resize 256x256 resized_$argv[1]
end

function jo

  jpegoptim -s $argv
end
  #
  # jo --size=50k x.jpg
  #
  # WARNING: affects the target file!

# https://dataswamp.org/~solene/2021-09-07-potw-pngquant.html
  #
  # optipng
  # pngquant

function tojpg

  for arg in $argv
    echo "$arg --> $arg.jpg"
    convert $arg $arg.jpg
  end
end

