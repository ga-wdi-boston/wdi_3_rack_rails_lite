module PersonApp
  class ApplicationController

    attr_accessor :params, :controller, :action

    def initialize()
      @params = {}
    end

    # takes a URL path, /people/5, and create a 
    # params hash, {id: 5}

    def path_to_params(path)
      id = path.split("/").last.to_i
      @params.merge!({id: id})
    end

    # Build the path to an action's view
    def view_filename
      "#{$RAILS_ROOT}/app/views/#{self.controller}/#{self.action}.html.erb"
    end

    def render()
      # Read the contents of the view template
      template = File.read(view_filename)
      # Pass this contents to erubis
      eruby = Erubis::Eruby.new(template)

      # Process the contents of the view template.
      eruby.result(binding())

      # NOTE: binding method above.
      # This will make available all the instance variables in this 
      # controller to the view.

    end

  end
end