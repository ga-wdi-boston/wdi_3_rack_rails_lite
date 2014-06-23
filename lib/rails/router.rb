module PersonApp
  class Router
    # A Hash of all the routes.
    # The key is the path from the URL
    # The value is a hash of the controller class and action name.
    # {controller: PersonController, action: action_name}
    @@routes = { }
    
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
      @@routes[path] = {controller: controller_klass, action: action_name }
    end

    def self.dispatch(request)
      controller_action_hash = @@routes[request.path_info]
      controller_klass = controller_action_hash[:controller]
      action =  controller_action_hash[:action]
      controller_klass.new.send(action.to_sym)
    end
  end
end
