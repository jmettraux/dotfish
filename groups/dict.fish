
# dict aliases

function dct
  #dict $argv | $PAGER
  dict $argv | less
end
function dth
  dict -d moby-thesaurus $argv
end
function djp
  dict -d fd-eng-jpn $argv
  echo
  dict -d fd-fra-jpn $argv
  echo
  dict -d fd-ita-jpn $argv
  echo
end

