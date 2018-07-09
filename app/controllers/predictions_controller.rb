class PredictionsController < ApplicationController
  def show
    prediction = ConcertPrediction.find(params[:id])
    render json: prediction
  end

  def create
    concert = Concert.find(params[:concert_id])
    concert_prediction = ConcertPrediction.new(concert_id: concert.id, user_id: @current_user.id)
    params["song_predictions"].each do |song_prediction|
      concert_prediction.song_predictions.build(song_id: song_prediction["song_id"], prediction_category_id: song_prediction["prediction_category_id"])
    end

    if concert_prediction.save!
      render json: concert_prediction
    else
      # Consider 400 error code
      render json: { error: 'Problem Saving Prediction' }, status: 422
    end
  end
end
