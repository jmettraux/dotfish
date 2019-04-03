
set -gx EDITOR vim

source ~/.fish/ls.fish
source ~/.fish/git.fish
source ~/.fish/vim.fish

for pa in _*.fish
  source $pa
end

