module SongsApp
  class Song
    @songs = []

    def self.all
      @songs
    end
    def self.create(name, description, duration, price)
      @songs << Song.new(name, description, duration, price)
    end

    def self.find(index)
      @songs[index.to_i]
    end

    attr_accessor :name, :description, :duration, :price

    def initialize(name, description, duration, price)
      @name, @description, @duraton, @price = name, description, duration, price
    end

    def to_html
      html = "<dt>Name</dt><dd>#{name}</dd>"
      html << "<dt>Description</dt><dd>#{description}</dd>"
      html << "<dt>Duration</dt><dd>#{duration}</dd>"
      html << "<dt>Price</dt><dd>#{price}</dd>"
    end
  end
end
