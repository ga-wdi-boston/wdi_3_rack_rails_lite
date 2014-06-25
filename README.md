#### Building Rails Lite

We are going to build an application from Ruby, Rack and ActiveSupport. 

The objective of this lesson is show how Rails works from the inside. This will incrementally build a _Lite_ version of some of the Rails components. 

It will:  
* Create an Rails _like_ initialization process.  
* Use the Rails directory structure.  
* Create a Rackup to process HTTP Requests.  
* Implementing a simple Router that will _dispatch_ HTTP Requests to the correct controller and action.  
* Implement a Controller and two actions, (index and show).  
* Implement a view using a _render_ method and erubis.


We've already seen Rack.  

ActiveSupport is one of the gems that make up RubyOnRails. It will extend a set of Ruby files, (Array, Hash, String, ..), and provide some naming and other behavior. Feel free to checkout ActiveSupport.

Later we'll also be using the Erubis gem that will provide _Templating_ to generate a HTML _Representation_ of our resources.  

Rails uses ERB for Templating but Erubis is very similar.

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

	We are, _unlike in Rails_, creating a lib/rails dir that will contain ruby that typically is provided by one of the rails gems.

```
mkdir lib
mkdir -p lib/rails
```
### Create a Rackup, config.ru
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

This will look at the HTTP Request method and path to determine what to do.

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
        else
          response_body = "Unknown route for #{request.request_method}, path #{path}"
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

__Goto http://localhost:3000/people and http://localhost:3000/people/4.__


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

__Goto http://localhost:3000/people and http://localhost:3000/people/4.__


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

__Goto http://localhost:3000/people and http://localhost:3000/people/4.__


### Create a (fake) Person model.

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

    attr_accessor :name, :description, :age

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

### Use these "models" in the controller actions.
Add some html to the app/controllers/application_controller.rb

```
 LAYOUT_HTML_PRE = '<html><head></head><body>'
 LAYOUT_HTML_POST = '</body></html>'
```

In the app/controllers/people_controller.rb.  

```
module PersonApp
  class PeopleController < ApplicationController

    def index
      @people = People.all

      # render the HTML
      content = LAYOUT_HTML_PRE
      @people.each do |person|
        content += person.to_html
      end
      content += LAYOUT_HTML_POST
    end

    def show 
      @person = Person.find(params[:id])
      content = LAYOUT_HTML_PRE
      content += @person.to_html
      content += LAYOUT_HTML_POST
    end
  end
end
```

In the config/application.rb 

Set the HTTP Response Content Type to html.  

```
 response.header['Content-Type'] = 'text/html'

```

## View Templates for Rendering.

We are going to use Erubis, _much like ERB in Rails_ , for a templating library. 

Templates generate HTML but can __also__ have ruby embedded in them. We'll see how this works below.


##### Install the erubis gem and require it.

* In the Gemfile. 

```
gem 'erubis'
```

Run bundle install.

* In the config/environment.rb file add the below after $RAILS_ROOT.  

```
 # Get active support help                                                   
require 'active_support/all'

 # For view templates.                                                       
require 'erubis'
```

#### Use erubis to render.

In the app/controllers/application_controller.rb. Remove the render method and replace it with the below.

__NO NEED TO UNDERSTAND THIS IMPLEMENTATION__. _But, feel free to knock your own self out_

```
...

attr_accessor :params, :controller, :action
...
 
 # determine the name of the current controller.
def controller
  @controller = self.class.name.split("Controller").first
  # remove the module name
  @controller = @controller.split("::").last.underscore
end

def view_filename
  "#{$RAILS_ROOT}/app/views/#{self.controller}/#{self.action}.html.erb"
end

 # Process the view template associated with the action
 # calling this render method. 
 # This method will return the HTML generated by the view template.
def render

 self.action = caller[0].split("`").pop.gsub("'", "")

 # Now we can determine the view, *.html.erb, file path
 template = File.read(view_filename)

 # Pass the contents of the view to erubis
 eruby = Erubis::Eruby.new(template)

 # binding() - make all the variables in this object available
 # inside the view template
 # result - Generate HTML from the view.
 eruby.result(binding())
end

```

##### Create the Views for people.

View templates alway live in the app/views/<resource>/<action>.html.erb files.


```
mkdir -p app/views/people
touch app/views/people/show.html.erb
touch app/views/people/index.html.erb
```

Add the contents to the show view.

In app/views/people/show.html.erb.  

```
<dt><%= @person.name %> </dt>
<dd><%= @person.description %> is <%= @person.age %> years old</dd>

```


In app/views/people/index.html.erb 

```
	<dl>
	  <% @people.each do |person| %>
	    <dt><%= person.name %> </dt>
	    <dd><%= person.description %> is <%= person.age %> years old</dd>
	  <% end %>
	</dl>
```







