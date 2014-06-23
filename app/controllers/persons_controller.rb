module PersonApp

  class PersonController < ApplicationController

    def index
      @people = Person.all
      layout do
        contents = ''
        @people.each do |person|
          contents += render('html',  person)
        end
        contents
      end
    end

    def show
      @person = Person.find(params[:id])
      layout do
        render 'html', @person
      end
    end
  end

end
