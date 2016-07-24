function urlencode --description "URL-encode strings"
  python -c "import sys, urllib as ul; print ul.quote_plus(\"$argv\");"
end

