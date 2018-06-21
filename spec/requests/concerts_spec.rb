require "rails_helper"

RSpec.describe "Concerts", type: :request do
  describe "GET /upcoming_concerts" do
    it "raises an error if a user is not authenticated" do
      get "/upcoming_concerts"
      expect(response.response_code).to eq(401)
    end

    it "returns a list of concerts" do
      user = create(:user)
      concerts = create_list(:concert, 2)

      token = sign_in_user(user)

      get "/upcoming_concerts", {}, {Authorization: token}

      expect(json.count).to eq(2)
      expect(json.first["id"]).to eq(concerts.first.id)
      expect(json.first["show_date"]).to eq(concerts.first.show_date)
      expect(json.first["venue_name"]).to eq(concerts.first.venue_name)
    end

    it "returns concerts in chronological order" do
      user = create(:user)
      create(:concert, show_date: 2.days.from_now)
      create(:concert, show_date: 1.days.from_now)
      token = sign_in_user(user)

      get "/upcoming_concerts", params: {authentication_token: token}

      expect(json.first.show_date).to be < json.second.show_date
    end
  end

  describe "GET /concerts/:id" do
    it "returns the concerts venue data"
    it "returns the concert's sets ordered by setlist position"
    it "returns the concerts song performances ordered by setlist position"
  end

  describe "GET /concerts" do
    it "raises an error if a user is not authenticated"
    it "returns a list of all concerts"
  end

  describe "POST /concerts" do
    it "raises an error if the authenticated user is not an admin"
    it "creates a new concert"
  end
end
