module SongsApp
  class Song
    # Fake DB, just a class instance variable
    # All songs will go away, poof, when you quit the 
    # app.
    @songs = []

    # Class methods
    class << self

      # All Songs.
      def all
        @songs
      end

      # Factory method to create a Song.
      def create(name, description, duration, price)
        @songs << Song.new(name, description, duration, price)
      end

      # Find a Song given it's index
      def find(index)
        @songs[index.to_i]
      end

    end # end of class methods

    attr_accessor :name, :description, :duration, :price

    def initialize(name, description, duration, price)
      @name, @description, @duraton, @price = name, description, duration, price
    end

  end
end
