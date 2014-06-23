module PersonApp
  Router.get('/people', "person#index")
  Router.get('/people/:id', "person#show")  
end
