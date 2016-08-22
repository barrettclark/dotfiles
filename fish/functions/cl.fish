function cl --description "Clears the screen then does a full directory listing" --wraps ls
  clear
  ls -la $argv
end

