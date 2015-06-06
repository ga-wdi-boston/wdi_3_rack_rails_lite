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
