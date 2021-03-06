require "rails_helper"

RSpec.describe "SetListParser" do
  describe "#parse" do
    context "with valid data" do
      before(:each) do
        parser = SetlistProcessing::SetlistParser.new(valid_setlist)
        @setlist_data = parser.parse
      end

      it "returns an array of concert sets" do
        expect(@setlist_data[:concert_sets].count).to eq(3)
      end

      it "includes a set number for each concert set" do
        expect(@setlist_data[:concert_sets].all?{|set| set[:set_number].present? }).to eq(true)
      end

      it "returns a list of song performances in that set" do
        first_song = @setlist_data[:concert_sets].first[:song_performances].first
        expect(first_song[:song_name]).to eq("Free")
      end

      it "returns a setlist position for a song performance" do
        first_song = @setlist_data[:concert_sets].first[:song_performances].first
        expect(first_song[:setlist_position]).to eq(0)
      end
    end

    context "with invalid data" do
      context "when an error message is present" do
        it "raises an error" do
          json = {error_code: 0, error_message: "Invalid Credentials", response: {count: 1, setlistdata: "setlist"}}.to_json
          parser = SetlistProcessing::SetlistParser.new(json)
          expect { parser.parse }.to raise_error(ApiParseError)
        end
      end

      context "when the response data is empty" do
        it "raises an error" do
          json = {error_code: 0, error_message: nil, response: {count: 1, data: []}}.to_json
          parser = SetlistProcessing::SetlistParser.new(json)
          expect { parser.parse }.to raise_error(ApiParseError)
        end
      end

      context "when no results are returned" do
        it "raises an error" do
          json = {error_code: 0, error_message: nil, response: {count: 0, data: []}}.to_json
          parser = SetlistProcessing::SetlistParser.new(json)
          expect { parser.parse }.to raise_error(ApiParseError)
        end
      end

      context "when setlist data is missing" do
        it "raises an error" do
          json = {error_code: 0, error_message: nil, response: {count: 1, data: [{info: "Information"}]}}.to_json
          parser = SetlistProcessing::SetlistParser.new(json)
          expect { parser.parse }.to raise_error(ApiParseError)
        end
      end

      context "when there are no set paragraphs in the returned html" do
        it "raises an error" do
          json = {error_code: 0, error_message: nil, response: {count: 1, data: [{setlistdata: "<h1>No Setlist!</h1>"}]}}.to_json
          parser = SetlistProcessing::SetlistParser.new(json)
          expect { parser.parse }.to raise_error(ApiParseError)
        end
      end
    end
  end
end

def valid_setlist
  "{\"error_code\":0,\"error_message\":null,\"response\":{\"count\":1,\"data\":[{\"showid\":1516747257,\"showdate\":\"2018-07-17\",\"short_date\":\"07\\/17\\/2018\",\"long_date\":\"Tuesday 07\\/17\\/2018\",\"relative_date\":\"1 month ago\",\"url\":\"http:\\/\\/phish.net\\/setlists\\/phish-july-17-2018-lake-tahoe-outdoor-arena-at-harveys-stateline-nv-usa.html\",\"gapchart\":\"http:\\/\\/phish.net\\/setlists\\/gap-chart\\/phish-july-17-2018-lake-tahoe-outdoor-arena-at-harveys-stateline-nv-usa.html\",\"artist\":\"<a href='http:\\/\\/phish.net\\/setlists\\/phish'>Phish<\\/a>\",\"artistid\":1,\"venueid\":960,\"venue\":\"<a href=\\\"http:\\/\\/phish.net\\/venue\\/960\\/Lake_Tahoe_Outdoor_Arena_at_Harveys\\\">Lake Tahoe Outdoor Arena at Harveys<\\/a>\",\"location\":\"Stateline, NV, USA\",\"setlistdata\":\"<p><span class='set-label'>Set 1<\\/span>: <a href='http:\\/\\/phish.net\\/song\\/free' class='setlist-song'>Free<\\/a> > <a href='http:\\/\\/phish.net\\/song\\/possum' class='setlist-song'>Possum<\\/a>, <a title=\\\"\\nThis cool version has an unusually improvisational outro which builds tension and peaks before flipping back to typical &quot;Moma&quot; to conclude.\\\" href='http:\\/\\/phish.net\\/song\\/the-moma-dance' class='setlist-song'>The Moma Dance<\\/a>, <a title=\\\"Page-guided white water rafting trip through a buttressed cathedral of an ice cream sundae. [A spirited first-set version that dives into a lovely Page-driven dreamscape before moving at Fish's urging to a driving, hard rocking jam. The jam closes with an amusing take on the usual &quot;Ghost&quot; ending, as the band slows down the tempo while dropping chromatically with each note played, almost like a turntable being played at an increasingly slower speed.]\\\" href='http:\\/\\/phish.net\\/song\\/ghost' class='setlist-song'>Ghost<\\/a> > <a href='http:\\/\\/phish.net\\/song\\/funky-bitch' class='setlist-song'>Funky Bitch<\\/a>, <a href='http:\\/\\/phish.net\\/song\\/stash' class='setlist-song'>Stash<\\/a>, <a href='http:\\/\\/phish.net\\/song\\/character-zero' class='setlist-song'>Character Zero<\\/a><\\/p><p><span class='set-label'>Set 2<\\/span>: <a href='http:\\/\\/phish.net\\/song\\/no-men-in-no-mans-land' class='setlist-song'>No Men In No Man's Land<\\/a> > <a href='http:\\/\\/phish.net\\/song\\/carini' class='setlist-song'>Carini<\\/a> -> <a href='http:\\/\\/phish.net\\/song\\/slave-to-the-traffic-light' class='setlist-song'>Slave to the Traffic Light<\\/a>, <a href='http:\\/\\/phish.net\\/song\\/bouncing-around-the-room' class='setlist-song'>Bouncing Around the Room<\\/a>, <a href='http:\\/\\/phish.net\\/song\\/soul-planet' class='setlist-song'>Soul Planet<\\/a> > <a href='http:\\/\\/phish.net\\/song\\/steam' class='setlist-song'>Steam<\\/a>, <a href='http:\\/\\/phish.net\\/song\\/harry-hood' class='setlist-song'>Harry Hood<\\/a><\\/p><p><span class='set-label'>Encore<\\/span>: <a href='http:\\/\\/phish.net\\/song\\/contact' class='setlist-song'>Contact<\\/a> > <a href='http:\\/\\/phish.net\\/song\\/julius' class='setlist-song'>Julius<\\/a>\",\"setlistnotes\":\"Summertime was teased and quoted before Moma Dance. Page teased Sprits in the Material World in the Hood intro.<br>via <a href=\\\"http:\\/\\/phish.net\\\">phish.net<\\/a>\",\"rating\":\"3.7641\"}]}}"
end
