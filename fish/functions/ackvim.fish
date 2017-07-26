function ackvim --description "generate a list of files that contain a search term and open them in vim at the first occurrence"
  vim +/$argv (ack -l $argv)
end

