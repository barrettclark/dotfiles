function escape --description "UTF-8-encode a string of Unicode symbols"
  printf "\\\x%s" (printf $argv | xxd -p -c1 -u)
end

