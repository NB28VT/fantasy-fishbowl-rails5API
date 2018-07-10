class UsersController < ApplicationController
  def concert_predictions
    # TODO: this is returning all users
    predictions = ConcertPrediction.where(user_id: params[:id])
    render json: predictions, root: "concert_predictions"
  end
end
