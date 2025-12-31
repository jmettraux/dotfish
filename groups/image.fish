
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

  for arg in (string split " " -- (eval echo $argv))
    echo "$arg --> $arg.jpg"
    convert $arg $arg.jpg
  end
end

function towebjpg

  for arg in (string split " " -- (eval echo $argv))
    echo "$arg --> $arg.jpg"
    convert $arg \
      -auto-orient \
      -resize '1024x1024>' \
      -strip \
      -quality 84 \
      -interlace Plane \
        $arg.jpg
  end
end

