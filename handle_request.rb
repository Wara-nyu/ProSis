def handle_request to_client
  request_line = to_client.readline
  url = request_line URI.host
  puts url
end
