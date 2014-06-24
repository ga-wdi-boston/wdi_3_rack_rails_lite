module PersonApp
  class PeopleController < ApplicationController

    def index
      @people = Person.all

      # render the HTML
      render @people
    end

    def show 
      @person = Person.find(params[:id])
      render @person
    end
  end
end