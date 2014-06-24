module PersonApp
  class PeopleController < ApplicationController

    def index
      @people = People.all

      # render the HTML
      content = LAYOUT_HTML_PRE
      @people.each do |person|
        content += person.to_html
      end
      content += LAYOUT_HTML_POST
    end

    def show 
      @person = Person.find(params[:id])
      content = LAYOUT_HTML_PRE
      content += @person.to_html
      content += LAYOUT_HTML_POST
    end
  end
end