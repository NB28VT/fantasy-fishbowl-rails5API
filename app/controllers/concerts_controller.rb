class ConcertsController < ApplicationController
  def index
    concerts = Concert.all.order("show_date ASC")
    render json: concerts, each_serializer: ConcertIndexSerializer
  end

  def upcoming
    concerts = Concert.where("show_date > ?", Time.now).order("show_date ASC")
    render json: concerts, each_serializer: ConcertIndexSerializer
  end
end
