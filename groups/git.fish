
function giu
  git status
end
function gid
  git diff --cached $argv
end

function gids
  git diff --cached --stat $argv
end
function gdw
  git diff --word-diff $argv
end
function gdp
  git diff --patience $argv
end
function gis
  git show $argv
end
function giss
  git show --stat $argv
end
function gil
  git log --graph --oneline --abbrev-commit --decorate $argv
end
function glb
  git log --graph --oneline --abbrev-commit --decorate --branches $argv
end
function gilb
  git log --graph --oneline --abbrev-commit --decorate --branches $argv
end

