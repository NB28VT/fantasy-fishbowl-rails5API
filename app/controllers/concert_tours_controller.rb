class ConcertToursController < ApplicationController
    skip_before_action :authenticate_request

    def index
        concert_tours = ConcertTour.all
        render json: concert_tours
    end

    def show
        concert_tour = ConcertTour.find(params[:id])
        render json: concert_tour
    end
end
