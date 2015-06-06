class Router

  @routes = { get: [],
              post: [],
              put: [],
              patch: [],
              delete: []
            }

  # Generate method, based on the HTTP methods, that will take
  # a path and controller#action pair. For example.
  # get "/people", "person#index"
  # get "/people/:id", "person#show"
  # post "/people", "person#create"
  # patch "/people/:id", "person#update"
  class << self
    [:get, :post, :patch, :put, :delete].each do |http_method|
      define_method(http_method) do |path, controller_action_str|

        # get the controller and action name
        controller_name, action_name = controller_action_str.split('#')
        controller_name = "#{controller_name.classify.pluralize}Controller"

        # create and instance of a Route and add it to array of routes
        # for HTTP Methods, (GET, POST, ... )
        @routes[http_method] << Route.new(path,controller_name, action_name)
      end
    end
  end

  # Define the routes in the block passed to this method
  # Will typically do an instance_eval of the block passed
  # unless the block has a param
  def self.draw(app_namespace, &block)
    Route.app_namespace = app_namespace
    if block_given?
      block.arity < 1 ? instance_eval(&block) : block.call(self)
    end
  end

  # Given a path dispatch to a controller action.
  def self.dispatch(http_method, path)

    # The routes for a specific HTTP Method, (GET, POST, ...)
    route_entries = @routes[http_method.downcase.to_sym]

    # Find the first route for the URL path
    route = route_entries.select do |route|
      if !route.segmented_path?
        # easy, just check the route path against the URL path
        route.path == path
      else
        # check that the segments that make up a path are the same.
        # segments are delimited by the slash, '/'
        route.same?(path)
      end
    end.first

    # boohoo, no route found, waaaa!
    if !route
      "No Route for #{http_method} - #{path}"
    else
      # Run the Controller action, this will return a body content
      route.invoke_action(path)
    end
  end
end
