module PersonApp
  class Person

    # class variable
    # fake people table
    @@people = []

    # class method to return all people
    def self.all
      @@people
    end

    # class method to create a person
    def self.create(name, description, age)
      @@people << Person.new(name, description, age)
    end

    # class method to find a person by index/id
    def self.find(index)
      @@people[index.to_i]
    end

    # 
    attr_accessor :name, :description, :age

    def initialize(name, description, age)
      @name, @description, @age = name, description, age
    end

    def to_html
      "<dt>#{@name}</dt><dd>#{@description} is #{@age} years old</dd>"
    end
  end
end