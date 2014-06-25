module PersonApp
  class ApplicationController

    LAYOUT_HTML_PRE = '<html><head></head><body>'
    LAYOUT_HTML_POST = '</body></html>'

    attr_accessor :params, :controller, :action

    def initialize()
      @params = {}
    end

    def path_to_params(path)
      id = path.split("/").last.to_i
      @params.merge!({id: id})
    end

    def controller
      # WARNING! Done by rails.
      # example: PersonApp::PersonController
      @controller = self.class.name.split("Controller").first
      # PersonApp::Person

      # remove the module name
      @controller = @controller.split("::").last.underscore
      # person
    end

    def view_filename
       # WARNING! Done by rails.
      "#{$RAILS_ROOT}/app/views/#{self.controller}/#{self.action}.html.erb"
    end

    # give a action invoke a view template.
    def render()
      # WARNING! NO NEED TO UNDERSTAND THIS
      self.action = calling_method = caller[0].split("`").pop.gsub("'", "")     
      template = File.read(view_filename)
      eruby = Erubis::Eruby.new(template)
      eruby.result(binding())
    end
  end # end class
end 