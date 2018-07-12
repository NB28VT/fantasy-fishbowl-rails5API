class SongsController < ApplicationController
  def index
    songs = Song.all.order("name ASC")
    render json: songs
  end
end
