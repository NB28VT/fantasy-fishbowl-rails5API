require "rails_helper"

RSpec.describe "Songs", type: :request do
  before(:each) do
    user = create(:user)
    @token = sign_in_user(user)
  end

  describe "GET /songs" do
    it "returns a list of all songs" do
      songs = create_list(:song, 2)

      get "/songs", params: {}, headers: {Authorization: @token}

      expect(json["songs"].count).to eq(2)
    end

    it "returns songs in order of name ascending" do
      song_2 = create(:song, name: "B")
      song_1 = create(:song, name: "A")

      get "/songs", params: {}, headers: {Authorization: @token}

      expect(json["songs"].first).to eq(
        {
          "id" => song_1.id,
          "name" => song_1.name
        }
      )
    end
  end
end
