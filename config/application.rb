module PersonApp
  class PeopleService

    def call(env)
      request = Rack::Request.new(env)
      response = Rack::Response.new
      response_body = ""

      # Simple router
      # Will HTTP Methods and Paths to Controller, class, actions, methods.
      if request.request_method == 'GET'
        response_body = Router.dispatch(request)
        # if request.path_info =~ /\/people\/+\d/
        #   # Person Controller show action          
        #   # params = {id: request.path_info.split('/').last.to_i }
        #   params = Utils.extract_params(request, request.path_info)
        #   puts "params = #{params}"
        #   person_controller = PersonApp::PersonController.new
        #   person_controller.params = params
        #   response_body = person_controller.show
        # else
        #   puts "Undefined route"
        #   response_body = "Undefined route"
        # end
        response.write(response_body)
      end
      response.finish
    end
  end
end

