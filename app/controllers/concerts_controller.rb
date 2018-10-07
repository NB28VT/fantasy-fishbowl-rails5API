class ConcertsController < ApplicationController
  skip_before_action :authenticate_request

  def index
    concerts = Concert.all.order("show_time ASC")
    render json: concerts, each_serializer: ConcertIndexSerializer
  end

  def upcoming
    concerts = Concert.where("show_time > ?", Time.now).order("show_time ASC")
    render json: concerts, each_serializer: ConcertIndexSerializer
  end

  def show
    concert = Concert.find(params[:id])
    render json: concert
  end
end
