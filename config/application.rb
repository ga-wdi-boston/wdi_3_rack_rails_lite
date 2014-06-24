module PersonApp
  class PeopleService

    def call(env)
      request = Rack::Request.new(env)
      response = Rack::Response.new
      response_body = ""

      # Simple router
      # Will HTTP Methods and Paths to Controller, class, actions, methods.
      response_body = Router.dispatch(request)
      response.write(response_body)
      response.finish
    end
  end
end

