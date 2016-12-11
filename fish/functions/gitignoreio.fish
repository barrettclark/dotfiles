function gitignoreio --description "Generate a .gitignore file from gitignore.io"
  set langs (string join ',' $argv)
  curl -o .gitignore https://www.gitignore.io/api/$langs
end

