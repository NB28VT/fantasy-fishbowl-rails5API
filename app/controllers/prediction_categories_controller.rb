class PredictionCategoriesController < ApplicationController
  # TODO: revert once auth is sorted out
  skip_before_action :authenticate_request

  def index
    prediction_catgories = PredictionCategory.all
    render json: prediction_catgories
  end
end
