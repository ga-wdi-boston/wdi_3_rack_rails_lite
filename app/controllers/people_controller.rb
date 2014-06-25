module PersonApp
  class PeopleController < ApplicationController

    def index
      @people = Person.all

      # render the HTML
      render()
    end

    def show 
      @person = Person.find(params[:id])
      render
    end
  end
end
