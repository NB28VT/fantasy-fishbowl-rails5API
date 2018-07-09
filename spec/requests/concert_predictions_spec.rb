require "rails_helper"

RSpec.describe "Concert Predictions" do
  before(:each) do
    @user = create(:user)
    @token = sign_in_user(@user)
  end

  describe "POST /concerts/:id/prediction" do
    it "creates a concert prediction" do
      concert = create(:concert)

      post "/concerts/#{concert.id}/predictions", params: { song_predictions: []}.to_json, headers: {Authorization: @token, "Content-Type" => "application/json"}

      expect(response.response_code).to eq(200)
      expect(concert.concert_predictions.count).to eq(1)
      concert_prediction = concert.concert_predictions.first

      expect(json["concert_prediction"]["id"]).to eq(concert_prediction.id)
      expect(concert_prediction).to have_attributes(user_id: @user.id, concert_id: concert.id)
    end

    it "creates song predictions for a given prediction category" do
      concert = create(:concert)
      songs = create_list(:song, 2)
      prediction_category = create(:prediction_category, name: "First Set Opener")

      post "/concerts/#{concert.id}/predictions", params: {
        song_predictions: [
          {
            song_id: songs.first.id,
            prediction_category_id: prediction_category.id
          }
        ]
      }, headers: {Authorization: @token}

      concert_prediction = concert.concert_predictions.first
      song_prediction = concert_prediction.song_predictions.first
      expect(song_prediction).to have_attributes(
        song_id: songs.first.id,
        prediction_category_id: prediction_category.id
      )
    end

    it "raises an error if two song predictions are submitted for the same category"
    it "raises an error if the deadline for creating a prediction has passed"
  end

  describe "GET /concerts/:id/predictions/:id" do
    it "returns a prediction's details" do
      concert = create(:concert)
      prediction = create(:concert_prediction, concert: concert, user: @user)
      prediction_category = create(:prediction_category)
      song_prediction = create(:song_prediction, concert_prediction: prediction, prediction_category: prediction_category)

      get "/concerts/#{concert.id}/predictions/#{prediction.id}", params: {}, headers: {Authorization: @token}

      expect(json["concert_prediction"]).to eq(
        {
          "id" => prediction.id,
          "concert_id" => concert.id,
          "song_predictions" => [
            {
              "id" => song_prediction.id,
              "song" => song_prediction.song.name,
              "category" => song_prediction.prediction_category.name
            }
          ]
        }
      )
    end
  end

  describe "PUT /concerts/:id/predictions/id:" do
    it "changes the song for a prediction" do

    end
    it "verifies the user owns the prediction they are are editing"
    it "raises an error if the deadline for editing a prediction has passed"
  end


  describe "GET /user/:id/predictions" do
    it "returns a list of the users predictions"
  end

  describe "GET /concerts/:id/predictions" do
    it "returns a list of all predictions for a concert"
    it "includes the final score for a prediction"
  end

  describe "GET /concerts/:id/predictions" do
    it "returns all prediction for a concert"
  end

end
