#\ -p 3000

# Above will Run this rackup on port 3000
require 'rack/lobster'

# setup the environment
require ::File.expand_path('../config/environment',  __FILE__)

# Run the Rack app.
run FishCake.new(Rack::Lobster.new(PersonApp::PeopleService.new)))

