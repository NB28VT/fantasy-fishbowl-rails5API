class ConcertsController < ApplicationController
  def index
    concerts = Concert.all
    render json: concerts, each_serializer: ConcertIndexSerializer
  end
end
