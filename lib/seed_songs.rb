require 'faker'

songs_num = 5
puts "Creating #{songs_num} people"

songs_num.times do |i|
  SongsApp::Song.create(Faker::Company.name, Faker::Hacker.say_something_smart, rand(600), 1.49)
end
