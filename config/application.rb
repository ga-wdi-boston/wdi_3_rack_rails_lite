module PersonApp
  class PeopleService

    def call(env)
      request = Rack::Request.new(env)
      response = Rack::Response.new
      response_body = ""

      puts "request.path_info  = #{request.path_info}"
      
      # Set the HTTP Response Content-Type to Plain text
      # response.header['Content-Type'] = 'text/plain'

      if request.request_method == 'GET'
        if request.path_info == '/people'
          response_body = PersonApp::PersonController.new.index
        elsif request.path_info =~ /\/people\/+\d/

          params = {id: request.path_info.split('/').last.to_i }
          puts "params = #{params}"

          person_controller = PersonApp::PersonController.new
          person_controller.params = params
          response_body = person_controller.show
        else
          puts "Undefined route"
          response_body = "Undefined route"
        end
        response.write(response_body)
      end
      response.finish
    end
  end
end

