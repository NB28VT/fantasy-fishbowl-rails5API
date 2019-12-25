class UsersController < ApplicationController
  def predictions
    predictions = ConcertPrediction.where(user_id: params[:id])
    render json: predictions, root: "concert_predictions"
  end

  def leaderboard
    # init leaderboard calculation service
    # pass in all users
    # serialize in a list ordered by the rankings top to bottom
  end
end
