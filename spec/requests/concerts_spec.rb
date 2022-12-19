require "rails_helper"

RSpec.describe "Concerts", type: :request do
  before(:each) do
    user = create(:user)
    @token = sign_in_user(user)
  end

  describe "GET /concerts" do
    it "returns a list of concerts" do
      concerts = create_list(:concert, 2)

      get "/concerts", params: {}, headers: {Authorization: @token}

      expect(json["concerts"].count).to eq(2)
    end

    it "returns concerts in chronological order by show date" do
      create(:concert, show_time: 2.days.from_now)
      create(:concert, show_time: 1.days.from_now)

      get "/concerts", params: {}, headers: {Authorization: @token}

      first_show_date = Date.strptime(json["concerts"].first["show_time"], "%m/%d/%Y")
      second_show_date = Date.strptime(json["concerts"].second["show_time"], "%m/%d/%Y")
      expect(first_show_date).to be < second_show_date
    end
  end

  describe "GET /concerts/upcoming" do
    it "returns a list of upcoming concerts" do
      upcoming_concert = create(:concert, show_time: 1.days.from_now)
      past_concert = create(:concert, show_time: 1.days.ago)

      get "/concerts/upcoming", params: {}, headers: {Authorization: @token}

      expect(json["concerts"].count).to eq(1)

      show_time = json["concerts"].first["show_time"]
      formatted_date = Date.strptime(show_time, "%m/%d/%Y")
      expect(formatted_date).to be > Date.current
    end

    it "sorts concerts in chronological order by show date" do
      create(:concert, show_time: 2.days.from_now)
      create(:concert, show_time: 1.days.from_now)

      get "/concerts/upcoming", params: {}, headers: {Authorization: @token}

      first_show_date = Date.strptime(json["concerts"].first["show_time"], "%m/%d/%Y")
      second_show_date = Date.strptime(json["concerts"].second["show_time"], "%m/%d/%Y")
      expect(first_show_date).to be < second_show_date
    end

  end

  describe "GET /concerts/:id" do
    context "when a show has already occured" do
      it "returns basic concert information" do
        concert = create(:concert)

        get "/concerts/#{concert.id}", params: {}, headers: {Authorization: @token}

        expect(json["concert"]).to eq(
          {
            "id" => concert.id,
            "show_time" => concert.show_time.strftime("%m/%d/%Y"),
            "venue_name" => concert.venue_name,
            "venue_image_src" => nil,
            "concert_sets" => []
          }
        )
      end

      it "returns the concert's sets ordered by set number" do
        concert = create(:concert)
        concert_set_1 = create(:concert_set, concert: concert, set_number: 1)
        concert_set_2 = create(:concert_set, concert: concert, set_number: 2)

        get "/concerts/#{concert.id}", params: {}, headers: {Authorization: @token}

        concert = json["concert"]
        expect(concert["concert_sets"].count).to eq(2)
        expect(concert["concert_sets"].first["set_number"]).to eq(1)
        expect(concert["concert_sets"].second["set_number"]).to eq(2)

        expect(concert["concert_sets"].first).to eq(
          {
            "set_number" => concert_set_1.set_number,
            "song_performances" => []
          }
        )
      end

      it "returns the concerts song performances ordered by setlist position" do
        concert = create(:concert)
        concert_set = create(:concert_set, concert: concert)
        song = create(:song)
        song_2 = create(:song)

        create(:song_performance, song: song_2, concert_set: concert_set, setlist_position: 2)
        song_1 = create(:song_performance, song: song, concert_set: concert_set, setlist_position: 1)

        get "/concerts/#{concert.id}", params: {}, headers: {Authorization: @token}

        set = json["concert"]["concert_sets"].first
        expect(set["song_performances"].first).to eq({"name" => song.name})
      end
    end

    context "when a show is yet to occur" do
      it "returns empty data for concert sets and song performances" do
        concert = create(:concert)

        get "/concerts/#{concert.id}", params: {}, headers: {Authorization: @token}

        expect(json["concert"]["concert_sets"]).to eq([])
      end
    end
  end

  describe "POST /concerts" do
    it "raises an error if the authenticated user is not an admin"
    it "creates a new concert"
  end
end
