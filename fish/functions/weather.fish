function weather --description "get weather for city or zipcode"
  curl -4 "http://wttr.in/$argv?u"
end

