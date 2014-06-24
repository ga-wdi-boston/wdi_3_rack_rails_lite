module PersonApp
  class ApplicationController
    attr_accessor :params
    def initialize()
      @params = {}
    end

    def path_to_params(path)
      id = path.split("/").last.to_i
      @params.merge!({id: id})
    end
  end
end