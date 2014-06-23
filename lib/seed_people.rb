require 'faker'
require_relative './utils'

people_num = 5
puts "Creating #{people_num} people"

people_num.times do |i|
  PersonApp::Person.create(Faker::Name.name, Faker::Name.title, rand(110))
end
