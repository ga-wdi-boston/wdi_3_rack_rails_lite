module PersonApp
  class Router
    # A Hash of all the routes.
    # The key is the path from the URL
    # The value is a hash of the controller class and action name.
    # {controller: PersonController, action: action_name}
    @@routes = {
      'GET' => { },
      'POST' =>  { },
      'PUT' => { },
      'PATCH' => { },
      'DELETE' => { }                  
    }

    # Map get request to a path
    # path - /people
    # controller_action_str - 'persons#index'
    def self.get(path, controller_action_str)
      controller_name, action_name = controller_action_str.split('#')
      
      controller_name.capitalize! # TODO CamelCase
      controller_name += 'Controller'
       
      # Get the controller class from name, "PersonController"
      controller_klass = ::PersonApp.const_get(controller_name)

      # Add the mapping from the URL path to the controller and action.
      @@routes['GET'][path] = {controller: controller_klass, action: action_name }
    end

    def self.dispatch(request)
      # URL Path
      path = request.path_info
      # HTTP method
      http_method = request.request_method
      
      # See if path is in routes.
      controller_action_hash = @@routes[http_method][path]

      if !controller_action_hash
        # no path in routes, replace last segment with :id
        path = path.split('/')[0..-2].join('/') + '/:id'
        controller_action_hash = @@routes[http_method][path]
      end
      # The controller class
      controller_klass = controller_action_hash[:controller]
      # The action name
      action =  controller_action_hash[:action]
      # Create an instance of the controller
      controller_obj = controller_klass.new
      # Set the controller's params
      controller_obj.params = Utils.extract_params(request)
      # Call the controller action
      controller_obj.send(action.to_sym)
    end
  end
end
