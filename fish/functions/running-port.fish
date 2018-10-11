function running-port --description "What application is running on the given port?"
  set pid (lsof -i TCP:$argv | grep LISTEN | awk '{ print $2 }')
  if [ $pid ]
    lsof -p $pid | grep cwd | awk '{ print "Process", $2, "is running from", $9  }'
  end
end

