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

```
module PersonApp
  class PeopleService
    def call(env)
      request = Rack::Request.new(env)
      response = Rack::Response.new
      response_body = ""

      # Simple router                                                           
      # Will dispatch, call, Controller actions based on a URL path.
      response_body = Router.dispatch(request)
      response.write(response_body)
      response.finish
    end
  end
end
```


