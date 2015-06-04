require 'pry'

# class on a line, PORO
# class Rails; def root=(); @root; end; end

# Rails.root =
$RAILS_ROOT = "#{__FILE__.split('/')[0..-3].join('/')}"
# Get active support help
# require 'active_support/all'

 # Require all of the rails files in these directories
Dir["#{$RAILS_ROOT}/app/controllers/**/*.rb"].each { |f| require(f) }
Dir["#{$RAILS_ROOT}/app/models/**/*.rb"].each { |f| require(f) }
Dir["#{$RAILS_ROOT}/lib/**/*.rb"].each { |f| require(f) }

require_relative "./application.rb"

 # Get active support help
require 'active_support/all'

# Gem for view templates
require 'erubis'
