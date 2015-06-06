module SongsApp
  class SongsController < ApplicationController

    def index
      @songs = Song.all
      # TODO: error handling

      # render the HTML
      render()
    end

    def show
      @song = Song.find(params[:id])
      # TODO: error handling
      render
    end
  end
end
