require 'rubygems'
require 'rack'

# This is a web application, Hurrah!
# Returns an Array with 3 elements.
# - HTTP Status Code
# - Hash used to form the HTTP Response Header
# - The contents, or body, of the HTTP Response
app = lambda { |env| [200, {'Content-Type' => 'text/plain'}, ["Hellow"] ]  }

# Start up Rack using the WEBrick HTTP Server
# Wait until a HTTP Request is sent to port 8111
# Then it will invoke the lambda 
Rack::Handler::WEBrick.run(app, Port: 8111)



