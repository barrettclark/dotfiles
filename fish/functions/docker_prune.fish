function docker_prune --description "Remove orphaned docker images" --wraps docker
  docker network prune
  docker system prune
end
