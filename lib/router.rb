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
        controller_name, action_name = controller_action_str.split('#')
        controller_name = "#{controller_name.classify.pluralize}Controller"
        @routes[http_method] << Route.new(path,controller_name, action_name)
      end
    end
  end

  # define the routes
  def self.draw(app_namespace, &block)
    Route.app_namespace = app_namespace
    if block_given?
      block.arity < 1 ? instance_eval(&block) : block.call(self)
    end
  end

  # Given a path dispatch to a controller action.
  def self.dispatch(http_method, path)

    route_entries = @routes[http_method.downcase.to_sym]
    route = route_entries.select { |route| route.path == path }.first

    if !route
      "No Route for #{http_method} - #{path}"
    else
      # keys = entry.map do |e|
      #   e[1..-1] if  e.index(':')
      # end.compact

      # values = entry.map do |e|
      #   |e| e if e =~ /\d/
      # end.compact
      byebug
      route.invoke_action
    end
  end
end
