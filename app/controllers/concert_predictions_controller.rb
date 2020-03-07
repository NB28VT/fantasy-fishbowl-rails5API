class ConcertPredictionsController < ApplicationController
  def index
    predictions = ConcertPrediction.where(concert_id: params[:concert_id])
    render json: predictions
  end

  def show
    prediction = ConcertPrediction.find(params[:id])
    render json: prediction
  end

  def create
    concert = Concert.find(params[:concert_id])
    full_params = concert_prediction_params.merge({concert_id: concert.id, user_id: @current_user.id})
    # full_params = concert_prediction_params.merge({user_id: @current_user.id})
    prediction = ConcertPrediction.new(full_params)

    if prediction.save!
      render json: prediction
    else
      # Consider 400 error code
      render json: { error: 'Problem Saving Prediction' }, status: 422
    end
  end

  def update
    concert_prediction = ConcertPrediction.find(params[:id])
    concert_prediction.update_attributes(concert_prediction_params)

    if concert_prediction.save!
      render json: concert_prediction
    else
      # Consider 400 error code
      render json: { error: 'Problem Saving Prediction' }, status: 422
    end
  end

  private

  def concert_prediction_params
    params.require(:concert_prediction).permit(:concert_id, :user_id, song_predictions_attributes: [:id, :song_id, :prediction_category_id])
  end

end
