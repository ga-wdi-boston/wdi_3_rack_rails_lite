#### Add ActiveSupport.

ActiveSupport is one of the gems used in rails. It creates a set of methods that extend Ruby classes. Check out the docs for ActiveSupport.

Add this to Gemfile.  

``` 
gem 'active_support'
```
### Create the directory structure

* Rails keeps it's controllers and models in the app directory.  

```
mkdir -p app/controllers
mkdir -p app/models
```

* The initialization, config and route definition files are contained in the config directory.

```
mkdir config
```

* A collection of other ruby files are keep in the lib directory.  

	We are, _unlike in Rails_, create a lib/rails dir that will contain ruby that typically is provided by one of the rails gems.

```
mkdir lib
mkdir -p lib/rails
```
### Create a config.ru
Create a rackup. This will initialize, or _bring up_, the application when the rackup command is invoked on the command line.

```
 #\ -p 3000

 # Above will Run this rackup on port 3000

 # setup the environment
 require ::File.expand_path('../config/environment',  __FILE__)

 # Run the Rack app.
 run PersonApp::PeopleService.new

```


### Create an enviroment.
The config/environment.rb file will require all the files from directories.

```
require 'pry'

$RAILS_ROOT = "#{__FILE__.split('/')[0..-3].join('/')}"

 # Get active support help                                                       
require 'active_support/all'

 # Require all of the rails files in these directories                           
Dir["#{$RAILS_ROOT}/app/controllers/**/*.rb"].each { |f| require(f) }
Dir["#{$RAILS_ROOT}/app/models/**/*.rb"].each { |f| require(f) }
Dir["#{$RAILS_ROOT}/lib/**/*.rb"].each { |f| require(f) }

require_relative "./application.rb"

```

### Create the Application class. This defines the Rack application. _Mucho importante_.

Create a config/application.rb 

This will look at the HTTP Method and path to determine what to do.

It's a very simple router. 

```
 # This is the Application class. 
 # It has only one method, call, which will accept HTTP Requests
 # And return HTTP Responses.


module PersonApp
  class PeopleService

    # env is the Hash formed by the HTTP Request
    def call(env)

      request = Rack::Request.new(env)
      response = Rack::Response.new
      response_body = ""

      path = request.path_info

      if request.request_method == 'GET'
        if path == '/people'
          response_body = "Show all the people"
        elsif path=~ /\/people\/+\d/
          puts "path is #{path}"
          id = path.split("/").last.to_i
          response_body = "Show one person with id = #{id}"
        end
      elsif request.request_method == 'POST'
      elsif request.request_method == 'PUT'        
      elsif request.request_method == 'PATCH'                
      elsif request.request_method == 'DELETE'                        
      esle

      end

      response.write(response_body)
      # Need this to calc the Content-Length Response header
      response.finish
    end
  end

end
```

Goto http://localhost:3000/people and http://localhost:3000/people/4.


### Create a PeopleController.

In the app/controller/people_controller.rb

```
module PersonApp
  class PeopleController

    def index
      "In the PeopleController#index method"
    end

    def show 
      "In the PeopleController#show method"      
    end
  end
end
```

In the config/application.rb file change.  

```
if path == '/people'
  response_body = PersonApp::PeopleController.new.index
elsif path=~ /\/people\/+\d/
  id = path.split("/").last.to_i
  response_body = PersonApp::PeopleController.new.show
end
```

This will route to the correct Controller and action.

#### Handle HTTRequest params for the show action.

Add a app/controllers/application.rb.  

Added a params hash and a method to populate the params hash from the path.

```
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
```


In the config/application.rb change.

```
elsif path=~ /\/people\/+\d/
          controller = PersonApp::PeopleController.new
          controller.path_to_params(path)
          response_body = controller.show
```

In the app/controllers/people_controller.rb.  

```
def show 
 "In the PeopleController#show with params = #{params.inspect}"      
end

```


### Create a (fake) Peson model.

In the app/models/person.rb file.

```
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
```

### Create a file that will populate the people.

In lib/seed_people.rb.  

```
require 'faker'
require_relative './utils'

people_num = 5
puts "Creating #{people_num} people"

people_num.times do |i|
  PersonApp::Person.create(Faker::Name.name, Faker::Name.title, rand(110))
end
```


