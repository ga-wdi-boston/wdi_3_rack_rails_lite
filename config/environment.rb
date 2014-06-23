require 'pry'

$RAILS_ROOT = "#{__FILE__.split('/')[0..-3].join('/')}"
# puts "RAILS_ROOT is #{$RAILS_ROOT}"

# Load all of the rails files in these directories
Dir["#{$RAILS_ROOT}/app/controllers/**/*.rb"].each { |f| load(f) }
Dir["#{$RAILS_ROOT}/app/models/**/*.rb"].each { |f| load(f) }
Dir["#{$RAILS_ROOT}/lib/**/*.rb"].each { |f| load(f) }


require_relative './application'

require_relative '../lib/seed_people'
