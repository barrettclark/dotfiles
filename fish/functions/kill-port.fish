function kill-port --description "Kill whatever is running on given port"
  lsof -t -i tcp:$argv | xargs kill
end

