module PersonApp
  class ApplicationController

    LAYOUT_HTML_PRE = '<html><head></head><body>'
    LAYOUT_HTML_POST = '</body></html>'

    attr_accessor :params

    def initialize()
      @params = {}
    end

    def path_to_params(path)
      id = path.split("/").last.to_i
      @params.merge!({id: id})
    end

    def render(object)
      content = LAYOUT_HTML_PRE
      if object.respond_to?(:each)
        object.each do |model|
          content += model.to_html          
        end
      else
        content += object.to_html
      end
      content += LAYOUT_HTML_POST
    end
  end
end