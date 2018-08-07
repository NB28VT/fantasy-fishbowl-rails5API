class SongsController < ApplicationController
  # TODO: revert once auth is sorted out
  skip_before_action :authenticate_request

  def index
    songs = Song.all.order("name ASC")
    render json: songs
  end

  def search
    songs = Song.where('name ILIKE ?', '%' + params[:query] + '%')
    render json: songs
  end
end
