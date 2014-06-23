module PersonApp
  class Utils
    def self.random_price
      (rand(1..10).to_f + rand(1..100).to_f/100).round(2)
    end

    # Extract the ID from the path into a params hash
    def self.extract_params(request, path="")
      params = { }.merge(request.params)
      unless path.empty?
        id = path.split('/').last.to_i
        params.merge!({id: id})
      end
      params
    end
    
  end
end

