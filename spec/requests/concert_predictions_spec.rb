require "rails_helper"

RSpec.describe "Concert Predictions" do
  before(:each) do
    user = create(:user)
    @token = sign_in_user(user)
  end

  describe "POST /prediction" do
    it "creates a concert prediction" do
      concert = create(:concert)
      songs = create_list(:song, 2)

      post "/prediction", params: {
        concert_id: concert.id,
        songs: [
          {
            song_id: songs.first.id,
            set_position: 1,
            set_number: 1
          },
          {
            song_id: songs.first.id,
            set_position: 2,
            set_number: 2
          },
        ]
      }, headers: {Authorization: @token}
    end
    
    it "creates song predictions for a given set and position number"
    it "raises an error if two "
    it "raises an error if the deadline for creating a prediction has passed"
    it "raises an error if a supplied concert can't be found"
    it "raises an error if a set and position number aren't supplied"
    it "raises an error if a song isn't found"
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

  describe "PUT /predictions/id:" do
    it "raises an error if the deadline for editing a prediction has passed"
  end
end
