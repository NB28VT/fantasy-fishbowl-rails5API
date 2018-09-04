require "rails_helper"

RSpec.describe "ConcertProcessor" do
  describe "#process" do
    context "with a valid API response" do
      before(:each) do
        allow_any_instance_of(PhishNetApiClient).to receive(:api_get).and_return(mocked_setlist_response)
        @concert = create(:concert)
        SetlistProcessing::ConcertProcessor.new(@concert).process
      end

      it "creates concert sets for a concert" do
        expect(@concert.concert_sets.count).to eq(3)
      end

      it "creates song performances for a concert" do
        expect(@concert.song_performances.count).to eq(16)

        possum = Song.find_by(name: "Possum")
        possum_performance = SongPerformance.find_by(concert_set: @concert.concert_sets.first, setlist_position: 1, song: possum)

        expect(possum_performance).to be_present
      end
    end
  end

  context "with an invalid API response" do
    it "raises an error" do
      mocked_response = {
        code: 200,
        body: {error_code: 0, error_message: "Invalid Credentials", response: {count: 1, setlistdata: "setlist"}}.to_json
      }
      allow_any_instance_of(PhishNetApiClient).to receive(:api_get).and_return(mocked_response)
      @concert = create(:concert)

      expect { SetlistProcessing::ConcertProcessor.new(@concert).process }.to raise_error(StandardError)
    end
  end
end

def mocked_setlist_response
  {
    code: 200,
    body: "{\"error_code\":0,\"error_message\":null,\"response\":{\"count\":1,\"data\":[{\"showid\":1516747257,\"showdate\":\"2018-07-17\",\"short_date\":\"07\\/17\\/2018\",\"long_date\":\"Tuesday 07\\/17\\/2018\",\"relative_date\":\"1 month ago\",\"url\":\"http:\\/\\/phish.net\\/setlists\\/phish-july-17-2018-lake-tahoe-outdoor-arena-at-harveys-stateline-nv-usa.html\",\"gapchart\":\"http:\\/\\/phish.net\\/setlists\\/gap-chart\\/phish-july-17-2018-lake-tahoe-outdoor-arena-at-harveys-stateline-nv-usa.html\",\"artist\":\"<a href='http:\\/\\/phish.net\\/setlists\\/phish'>Phish<\\/a>\",\"artistid\":1,\"venueid\":960,\"venue\":\"<a href=\\\"http:\\/\\/phish.net\\/venue\\/960\\/Lake_Tahoe_Outdoor_Arena_at_Harveys\\\">Lake Tahoe Outdoor Arena at Harveys<\\/a>\",\"location\":\"Stateline, NV, USA\",\"setlistdata\":\"<p><span class='set-label'>Set 1<\\/span>: <a href='http:\\/\\/phish.net\\/song\\/free' class='setlist-song'>Free<\\/a> > <a href='http:\\/\\/phish.net\\/song\\/possum' class='setlist-song'>Possum<\\/a>, <a title=\\\"\\nThis cool version has an unusually improvisational outro which builds tension and peaks before flipping back to typical &quot;Moma&quot; to conclude.\\\" href='http:\\/\\/phish.net\\/song\\/the-moma-dance' class='setlist-song'>The Moma Dance<\\/a>, <a title=\\\"Page-guided white water rafting trip through a buttressed cathedral of an ice cream sundae. [A spirited first-set version that dives into a lovely Page-driven dreamscape before moving at Fish's urging to a driving, hard rocking jam. The jam closes with an amusing take on the usual &quot;Ghost&quot; ending, as the band slows down the tempo while dropping chromatically with each note played, almost like a turntable being played at an increasingly slower speed.]\\\" href='http:\\/\\/phish.net\\/song\\/ghost' class='setlist-song'>Ghost<\\/a> > <a href='http:\\/\\/phish.net\\/song\\/funky-bitch' class='setlist-song'>Funky Bitch<\\/a>, <a href='http:\\/\\/phish.net\\/song\\/stash' class='setlist-song'>Stash<\\/a>, <a href='http:\\/\\/phish.net\\/song\\/character-zero' class='setlist-song'>Character Zero<\\/a><\\/p><p><span class='set-label'>Set 2<\\/span>: <a href='http:\\/\\/phish.net\\/song\\/no-men-in-no-mans-land' class='setlist-song'>No Men In No Man's Land<\\/a> > <a href='http:\\/\\/phish.net\\/song\\/carini' class='setlist-song'>Carini<\\/a> -> <a href='http:\\/\\/phish.net\\/song\\/slave-to-the-traffic-light' class='setlist-song'>Slave to the Traffic Light<\\/a>, <a href='http:\\/\\/phish.net\\/song\\/bouncing-around-the-room' class='setlist-song'>Bouncing Around the Room<\\/a>, <a href='http:\\/\\/phish.net\\/song\\/soul-planet' class='setlist-song'>Soul Planet<\\/a> > <a href='http:\\/\\/phish.net\\/song\\/steam' class='setlist-song'>Steam<\\/a>, <a href='http:\\/\\/phish.net\\/song\\/harry-hood' class='setlist-song'>Harry Hood<\\/a><\\/p><p><span class='set-label'>Encore<\\/span>: <a href='http:\\/\\/phish.net\\/song\\/contact' class='setlist-song'>Contact<\\/a> > <a href='http:\\/\\/phish.net\\/song\\/julius' class='setlist-song'>Julius<\\/a>\",\"setlistnotes\":\"Summertime was teased and quoted before Moma Dance. Page teased Sprits in the Material World in the Hood intro.<br>via <a href=\\\"http:\\/\\/phish.net\\\">phish.net<\\/a>\",\"rating\":\"3.7641\"}]}}"
  }
end
