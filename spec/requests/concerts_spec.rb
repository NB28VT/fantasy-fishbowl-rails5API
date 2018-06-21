require "rails_helper"

RSpec.describe "Concerts", type: :request do
  describe "GET /concerts" do
    it "raises an error if a user is not authenticated" do
      get "/concerts"
      expect(response.response_code).to eq(401)
    end

    it "returns a list of concerts" do
      user = create(:user)
      concerts = create_list(:concert, 2)

      token = sign_in_user(user)

      get "/concerts", params: {}, headers: {Authorization: token}

      expect(json["concerts"].count).to eq(2)
      expect(json["concerts"].first).to eq(
        {
          "id" => concerts.first.id,
          "show_date" => concerts.first.show_date.strftime("%m/%d/%Y"),
          "venue_name" => concerts.first.venue_name
        }
      )
    end

    it "returns concerts in chronological order by show date" do
      user = create(:user)
      create(:concert, show_date: 2.days.from_now)
      create(:concert, show_date: 1.days.from_now)
      token = sign_in_user(user)

      get "/concerts", params: {authentication_token: token}

      expect(json.first.show_date).to be < json.second.show_date
    end

    context "when only upcoming concerts are requested" do
      it "returns a list of upcoming concerts"
      it "does not return any concerts that have gone by"
    end

  end

  describe "GET /concerts/:id" do
    context "when a show has already occured" do
      it "returns the concerts venue data"
      it "returns the concert's sets ordered by setlist position"
      it "returns the concerts song performances ordered by setlist position"
    end

    context "when a show is yet to occur" do
      it "returns blank data for concert sets and song performances"
    end
  end

  describe "POST /concerts" do
    it "raises an error if the authenticated user is not an admin"
    it "creates a new concert"
  end
end
