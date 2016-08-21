function server --description 'Start an HTTP server from a directory'
  if count $argv > /dev/null
    set port $argv
  else
    set port 8000
  end
  sleep 1
  open "http://localhost:$port" &
	python -c '
import SimpleHTTPServer
map = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map
map[""] = "text/plain"
for key, value in map.items():
    map[key] = value + ";charset=UTF-8"

SimpleHTTPServer.test()
  ' $port
end
