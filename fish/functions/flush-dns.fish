function flush-dns --description "Flush Directory Service cache"
  dscacheutil -flushcache and killall -HUP mDNSResponder
end

