module PersonApp
  class Person
    @@people = []

    def self.all
      @@people
    end
    def self.create(name, description, age)
      @@people << Person.new(name, description, age)
    end

    def self.find(index)
      @@people[index.to_i]
    end
    
    attr_accessor :name, :description, :agee

    def initialize(name, description, age)
      @name, @description, @age = name, description, age
    end

    def to_html
      "<dt>#{@name}</dt><dd>#{@description} is #{@age} years old</dd>"
    end
  end
end
