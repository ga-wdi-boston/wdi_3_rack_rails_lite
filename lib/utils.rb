module PersonApp
  class Utils
    def self.random_price
      (rand(1..10).to_f + rand(1..100).to_f/100).round(2)
    end
  end
end

