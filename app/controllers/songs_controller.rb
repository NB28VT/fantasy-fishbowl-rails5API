class SongsController < ApplicationController
  def index
    songs = Song.all.order("name ASC")
    render json: songs
  end

  def search
    songs = Song.where('name ILIKE ?', '%' + params[:query] + '%')
    render json: songs
  end
end
