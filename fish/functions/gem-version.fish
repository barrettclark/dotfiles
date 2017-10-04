function gem-version --description "Tell me the latest version of the given gem"
  curl https://rubygems.org/api/v1/versions/$argv/latest.json | jq
end
