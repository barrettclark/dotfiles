function flush-dns --description "Flush Directory Service cache"
  sudo killall -HUP mDNSResponder
  sudo killall mDNSResponderHelper
  sudo dscacheutil -flushcache
end

