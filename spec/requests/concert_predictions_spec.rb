require "rails_helper"

RSpec.describe "Concert Predictions" do
  before(:each) do
    @user = create(:user)
    @token = sign_in_user(@user)
  end

  describe "POST /concerts/:id/concert_predictions" do
    it "creates a concert prediction" do
      concert = create(:concert)

      post "/concerts/#{concert.id}/concert_predictions", params: { concert_prediction: {song_predictions_attributes: []}}.to_json, headers: {Authorization: @token, "Content-Type" => "application/json"}

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

      post "/concerts/#{concert.id}/concert_predictions", params: {
        concert_prediction: {
          song_predictions_attributes: [
            {
              song_id: songs.first.id,
              prediction_category_id: prediction_category.id
            }
          ]
        }
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

  describe "GET /concerts/:id/concert_predictions/:id" do
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

  describe "PUT /concerts/:id/concert_predictions/:id" do
    it "changes the song for a prediction" do
      concert = create(:concert)
      prediction = create(:concert_prediction, concert: concert, user: @user)
      prediction_category = create(:prediction_category)
      old_song = create(:song, name: "Scooty Puff Jr.")
      new_song = create(:song, name: "Give Bender a Hug")
      song_prediction = create(:song_prediction, song: old_song, concert_prediction: prediction, prediction_category: prediction_category)

      put "/concerts/#{concert.id}/concert_predictions/#{prediction.id}", params:{
          concert_prediction: {
            song_predictions_attributes: [
              {id: song_prediction.id, song_id: new_song.id}
            ]
          }
      }.to_json, headers: {Authorization: @token, "Content-Type" => "application/json"}

      expect(json["concert_prediction"]).to eq(
        {
          "id" => prediction.id,
          "concert_id" => concert.id,
          "song_predictions" => [
            {
              "id" => song_prediction.id,
              "song" => new_song.name,
              "category" => song_prediction.prediction_category.name
            }
          ]
        }
      )
    end

    it "verifies the user owns the prediction they are are editing"
    it "raises an error if the deadline for editing a prediction has passed"
  end

  describe "GET /users/:id/concert_predictions" do
    it "returns a list of the users predictions" do
      predictions = create_list(:concert_prediction, 2, user: @user)

      get "/users/#{@user.id}/concert_predictions", params: {}, headers: {Authorization: @token}

      expect(json["concert_predictions"].count).to eq(2)
      expect(json["concert_predictions"].first).to eq(
        {
          "id" => predictions.first.id,
          "user_id" => @user.id,
          "concert_id" => predictions.first.concert_id,
          "song_performances" => predictions.first.song_predictions
          "score" => predictions.first.score
        }
      )
    end
  end

  describe "GET /concerts/:id/concert_predictions" do
    it "returns a list of all predictions for a concert" do
      concert = create(:concert)
      predictions = create_list(:concert_prediction, 2, concert: concert)

      get "/concerts/#{concert.id}/concert_predictions", params: {}, headers: {Authorization: @token}

      expect(json["concert_predictions"].count).to eq(2)
      expect(json["concert_predictions"].first).to eq(
        {
          "id" => predictions.first.id,
          "user_id" => predictions.first.user_id,
          "concert_id" => predictions.first.concert_id,
          "song_performances" => predictions.first.song_predictions
          "score" => predictions.first.score
        }
      )
    end
  end
end
