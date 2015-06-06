# This is the Application class.
# It has only one method, call, which will accept HTTP Requests
# And return HTTP Responses.
module SongsApp
  class SongsService

    # env is the Hash formed by the HTTP Request
    def call(env)

      request = Rack::Request.new(env)
      response = Rack::Response.new
      response_body = ""

      path = request.path_info

      response_body = Router.dispatch(request.request_method, path)
      response.header['Content-Type'] = 'text/html'

      response.write(response_body)
      # Need this to calc the Content-Length Response header
      response.finish
    end
  end

end
