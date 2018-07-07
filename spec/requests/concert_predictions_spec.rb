require "rails_helper"

RSpec.describe "Concert Predictions" do
  before(:each) do
    @user = create(:user)
    @token = sign_in_user(@user)
  end

  describe "POST /concerts/:id/prediction" do
    it "creates a concert prediction" do
      concert = create(:concert)

      post "/concerts/#{concert.id}/prediction", params: { song_predictions: []}.to_json, headers: {Authorization: @token, "Content-Type" => "application/json"}

      expect(response.response_code).to eq(200)
      # TODO: RETURN ID
      expect(concert.concert_predictions.count).to eq(1)
      concert_prediction = concert.concert_predictions.first

      expect(json["concert_prediction"]["id"]).to eq(concert_prediction.id)
      expect(concert_prediction).to have_attributes(user_id: @user.id, concert_id: concert.id)
    end

    it "creates song predictions for a given prediction category" do
      concert = create(:concert)
      songs = create_list(:song, 2)
      prediction_category = create(:prediction_category, name: "First Set Opener")

      post "/concerts/#{concert.id}/prediction", params: {
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
    it "raises an error if a supplied concert can't be found"
    it "raises an error if a set and position number aren't supplied"
    it "raises an error if a song isn't found"
  end

  describe "PUT /predictions/id:" do
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

  describe "GET /predictions/:id" do
    it "returns a prediction for a concert"
  end

end
