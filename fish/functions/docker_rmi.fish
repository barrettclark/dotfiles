function docker_rmi --description "Remove orphaned docker images" --wraps docker
  docker rmi (docker images -a | grep "^<none>" | awk '{print $3}') > /dev/null 2>&1
end
