function rvm-gem-global --description "Install gem for all gemsets in the current RVM Ruby"
  rvm @global do gem install $argv
end

