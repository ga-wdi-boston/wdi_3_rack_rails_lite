module PersonApp
  class PeopleController < ApplicationController

    def index
      "In the PeopleController#index method"
    end

    def show 
      "In the PeopleController#show with params = #{params.inspect}"      
    end

  end
end