#\ -p 3000

# Above will Run this rackup on port 3000

# setup the environment
require ::File.expand_path('../config/environment',  __FILE__)

# Run the Rack app.
run PersonApp::PeopleService.new

