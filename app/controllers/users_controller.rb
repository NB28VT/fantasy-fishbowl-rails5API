class UsersController < ApplicationController
  def predictions
    predictions = ConcertPrediction.where(user_id: params[:id])
    render json: predictions, root: "concert_predictions"
  end
end
