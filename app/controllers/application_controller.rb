module PersonApp

  class ApplicationController
    attr_accessor :params
    
    def layout(&block)
      contents = '<html><head><title>People App</title></head><body>'
      contents += yield
      contents += '</body></html>'
    end

    def render(type, object)
      contents = ""
      if type == 'html'
        contents += object.to_html
      elsif type == 'json'
        # TODO: 
        contents += object.to_json
      else
        contents += object.to_html
      end
      contents
    end
  end
end
