require "rails_helper"

RSpec.describe "Concerts", type: :request do
  before(:each) do
    user = create(:user)
    @token = sign_in_user(user)
  end

  describe "GET /concerts" do
    it "raises an error if a user is not authenticated" do
      get "/concerts"
      expect(response.response_code).to eq(401)
    end

    it "returns a list of concerts" do
      concerts = create_list(:concert, 2)

      get "/concerts", params: {}, headers: {Authorization: @token}

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
      create(:concert, show_date: 2.days.from_now)
      create(:concert, show_date: 1.days.from_now)

      get "/concerts", params: {}, headers: {Authorization: @token}

      first_show_date = Date.strptime(json["concerts"].first["show_date"], "%m/%d/%Y")
      second_show_date = Date.strptime(json["concerts"].second["show_date"], "%m/%d/%Y")
      expect(first_show_date).to be < second_show_date
    end
  end

  describe "GET /concerts/upcoming" do
    it "returns a list of upcoming concerts" do
      upcoming_concert = create(:concert, show_date: 1.days.from_now)
      past_concert = create(:concert, show_date: 1.days.ago)

      get "/concerts/upcoming", params: {}, headers: {Authorization: @token}

      expect(json["concerts"].count).to eq(1)

      show_date = json["concerts"].first["show_date"]
      formatted_date = Date.strptime(show_date, "%m/%d/%Y")
      expect(formatted_date).to be > Date.current
    end

    it "sorts concerts in chronological order by show date" do
      create(:concert, show_date: 2.days.from_now)
      create(:concert, show_date: 1.days.from_now)

      get "/concerts/upcoming", params: {}, headers: {Authorization: @token}

      first_show_date = Date.strptime(json["concerts"].first["show_date"], "%m/%d/%Y")
      second_show_date = Date.strptime(json["concerts"].second["show_date"], "%m/%d/%Y")
      expect(first_show_date).to be < second_show_date
    end

  end

  describe "GET /concerts/:id" do
    context "when a show has already occured" do
      it "returns basic concert information" do
        concert = create(:concert)

        get "/concerts/#{concert.id}", params: {}, headers: {Authorization: @token}

        concert = json["concert"]
        expect(concert["id"]).to eq(concert.id)
        expect(concert["show_date"]).to eq(concert.show_date)
        expect(concert["venue_name"]).to eq(concert.venue_name)
      end

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
