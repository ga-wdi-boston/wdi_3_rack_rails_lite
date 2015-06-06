module SongsApp
  class SongsController < ApplicationController

    def index
      @songs = Song.all

      # render the HTML
      render()
    end

    def show
      @song = Song.find(params[:id])
      render
    end
  end
end
