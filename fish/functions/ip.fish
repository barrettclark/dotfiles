function ip --description "Public IP Address"
  dig +short myip.opendns.com @resolver1.opendns.com
end

