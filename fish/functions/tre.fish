function tre --description "tree with hidden files and color enabled"
  tree -aC -I '.git|node_modules|bower_components' --dirsfirst $argv | less -FRNX;
end

