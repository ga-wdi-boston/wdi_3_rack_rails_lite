# Require all the dependencies.
require 'pry'

#
$RAILS_ROOT = "#{__FILE__.split('/')[0..-3].join('/')}"

# Get active support help
require 'active_support/all'

# For view templates.
require 'erubis'

# Require all of the rails files in these directories
Dir["#{$RAILS_ROOT}/app/controllers/**/*.rb"].each { |f| require(f) }
Dir["#{$RAILS_ROOT}/app/models/**/*.rb"].each { |f| require(f) }
Dir["#{$RAILS_ROOT}/lib/**/*.rb"].each { |f| require(f) }

require_relative "./application.rb"
require_relative "./routes.rb"
