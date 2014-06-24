require 'pry'

$RAILS_ROOT = "#{__FILE__.split('/')[0..-3].join('/')}"
# puts "RAILS_ROOT is #{$RAILS_ROOT}"

# Require all of the rails files in these directories
Dir["#{$RAILS_ROOT}/app/controllers/**/*.rb"].each { |f| require(f) }
Dir["#{$RAILS_ROOT}/app/models/**/*.rb"].each { |f| require(f) }
Dir["#{$RAILS_ROOT}/lib/**/*.rb"].each { |f| require(f) }

# Require the routes
require_relative './route.rb'

# Require the Rack app
require_relative './application'

# Create the People, power to the people, right on.
require_relative '../lib/seed_people'
