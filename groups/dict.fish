
# dict aliases

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

