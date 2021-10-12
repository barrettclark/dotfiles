function ackgo --description "search Golang files excluding tests and mocks" --wraps ack
  ack $argv[1] $argv[2] --ignore-file=match:/_test/ --ignore-file=match:/mock/
end

