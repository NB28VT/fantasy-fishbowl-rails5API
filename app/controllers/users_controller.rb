class UsersController < ApplicationController
  # TODO: Implement client-side authentication and fix this
  skip_before_action :authenticate_request

  def predictions
    predictions = ConcertPrediction.where(user_id: params[:id])
    render json: predictions, root: "concert_predictions"
  end

  def prediction_rankings
    rankings = User.rank_users
    render json: rankings
  end
end
