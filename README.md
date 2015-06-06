
# Building Rails Lite

We are going to build an application from Ruby, Rack and ActiveSupport. 

The objective of this lesson is show how Rails works from the inside. This will incrementally build a _Lite_ version of some of the Rails components. 

It will:  

* Create an Rails _like_ initialization process.  
* Use the Rails directory structure.  
* Create a Rackup to process HTTP Requests.  
* Implementing a simple Router that will _dispatch_ HTTP Requests to the correct controller and action.  
* Implement a Controller and two actions, (index and show).  
* Implement a view using a _render_ method and erubis.


This implementation assumes some familiarity with Rack.

We'll use ActiveSupport, a gem used in Rails, in order to use some nice methods that extend Ruby.

We'll also be using the Erubis gem that will provide _Templating_ to generate a HTML _Representation_ of our resources.  

Rails uses ERB for Templating but Erubis is very similar.

## Startup 
**Install the Ruby gems.**

```
bundle install
```

**To start the app on port 3000, we'll use rackup.**

```
rackup -p 3000

```

**Go to `http://localhost:3000/songs`**

You should see a list of songs.

**Go to `http://localhost:3000/songs/3`**

You should see a specific song. 


### Implementation

**On startup this app will, by default, invoke the code in the config.ru file.**

```
# To run on port 3000, like rails
# rackup -p 3000

# setup the environment
require ::File.expand_path('../config/environment',  __FILE__)

# Run the Rack app.
run SongsApp::SongsService.new

```

**This will invoke the config/environment.rb file.**

Here we will:  

* Require all of the Ruby files in a couple of directories.
* Require the code in the config/application.rb

**Run the Rack application, SongsService, defined in the config/application.rb**

* This will invoke the correct Controller and Action for a specific path. But the routes must be setup first.


#### Initialize the Routes

The routes for resoures are defined in the `config/routes.rb` file.

```
# create the routes, SongApp will be the application namespace.
Router.draw('SongsApp') do
  puts "Routes"
  get "/songs", "songs#index"
  get "/songs/:id", "songs#show"
  post "/songs", "songs#create"
  patch "/songs/:id", "songs#update"
  delete "/songs/:id", "songs#update"
  puts "routes are #{@routes.inspect}"
end
```

**The router is implemented in the `lib/router.rb` and `lib/route.rb` files.**


#### Initialize the Songs.

This application is not, *yet*, using a database. So we create a couple of Songs in the `lib/seed_songs.rb` file.

```
require 'faker'

songs_num = 5
puts "Creating #{songs_num} people"

songs_num.times do |i|
  SongsApp::Song.create(Faker::Company.name, Faker::Hacker.say_something_smart, rand(600), 1.49)
end

```

This uses the Song Ruby class. This class will implement some of the ActiveRecord/ActiveModel interface.

**See the app/models/song.rb file.**




