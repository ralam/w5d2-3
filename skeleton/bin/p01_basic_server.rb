require 'webrick'

server = WEBrick::HTTPServer.new(Port: 3000)

server.mount_proc("/") do |request, response|
  response.content_type = "text/text"
  unless request.path == "/"
    response.body = request.path
  else
    response.body = "root"
  end

end

trap('INT') do
  server.shutdown
end

server.start

# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick.html
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick/HTTPRequest.html
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick/HTTPResponse.html
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick/Cookie.html
