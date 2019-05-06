
# from https://stackoverflow.com/questions/34216850/how-to-prevent-iterm2-from-closing-when-typing-ctrl-d-eof

# original at /usr/local/share/fish/functions/delete-or-exit.fish

function delete-or-exit

  set -l cmd (commandline)

  switch "$cmd"

    case ''
      #exit 0  # default fish behaviour
      # do nothing, do not exit
    case '*'
      commandline -f delete-char
  end
end

