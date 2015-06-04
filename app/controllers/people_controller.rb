module PersonApp
  class PeopleController < ApplicationController

    def index
      content = ""
      Person.all.each do |person|
        content += person.to_html
      end
      content
    end

    def show 
      @person = Person.find(params[:id])
      render
    end

  end
end
