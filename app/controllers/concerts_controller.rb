class ConcertsController < ApplicationController
  skip_before_action :authenticate_request

  def index
    concerts = Concert.all.order("show_date ASC")
    render json: concerts, each_serializer: ConcertIndexSerializer
  end

  def upcoming
    concerts = Concert.where("show_date > ?", Time.now).order("show_date ASC")
    render json: concerts, each_serializer: ConcertIndexSerializer
  end

  def show
    concert = Concert.find(params[:id])
    render json: concert
  end
end
