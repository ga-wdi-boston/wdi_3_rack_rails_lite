# This is the Application class. 
# It has only one method, call, which will accept HTTP Requests
# And return HTTP Responses.

module PersonApp
  class PeopleService

    # env is the Hash formed by the HTTP Request
    def call(env)

      # Provided by Rack, Convenience

      # To get the HTTP Request info
      request = Rack::Request.new(env)
      # To form a HTTP Response
      response = Rack::Response.new
      response_body = ""

      path = request.path_info

      if request.request_method == 'GET'
       if path == '/people'
        controller = PersonApp::PeopleController.new
        controller.controller = 'people'
        controller.action = 'index'
        response_body = controller.index
      elsif path=~ /\/people\/+\d/
        controller = PeopleController.new
        controller.path_to_params(path)
        controller.controller = 'people'
        controller.action = 'show'
        response_body = controller.show
        # send will invoke the method named by it's 
        # first argument. First argument MUST be a symbol
        # Here we will invoke the show method
#         response_body = controller.send(show.to_sym)
      else
          response_body = "No route found for path #{path}"
        end
      elsif request.request_method == 'POST'
      elsif request.request_method == 'PUT'        
      elsif request.request_method == 'PATCH'                
      elsif request.request_method == 'DELETE'                        
      else
        response_body = "Barfomongo, huh? what? don't get it"
      end

      response.header['Content-Type'] = 'text/html'
      response.write(response_body)
      # Need this to calc the Content-Length Response header
      response.finish
    end
  end

end
