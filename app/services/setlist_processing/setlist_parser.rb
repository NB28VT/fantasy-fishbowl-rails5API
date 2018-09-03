class ApiParseError < StandardError; end

module SetlistProcessing
  class SetlistParser
    def initialize(concert_json)
      @concert_json = concert_json
    end

    def parse
      validate_setlist_data
      setlist = find_setlist
      document = Nokogiri::HTML(setlist)
      sets = document.search("p")
      raise ApiParseError, "No set paragraphs found" if sets.blank?

      concert_sets = sets.map.with_index{|set_data, set_index| build_concert_set(set_data, set_index)}
      return {concert_sets: concert_sets}
    end

    private

    def validate_setlist_data
      raise ApiParseError, "Error Pulling Setlist: #{@concert_json["error_message"]}" if @concert_json["error_message"].present?
      raise ApiParseError, "Setlist Not Found" if @concert_json["response"]["count"] == 0
    end

    def build_concert_set(set_data, set_index)
      song_performances = build_song_performances(set_data)
      return {set_number: set_index, song_performances: song_performances}
    end

    def build_song_performances(set_data)
      return set_data.search("a").map.with_index{|song, index|  {song_name: song.text, setlist_position: index}}
    end

    def find_setlist
      response_data = @concert_json.dig("response", "data")
      raise ApiParseError, "Empty response data" if response_data.blank?

      concert_data = response_data.find{|data| data.has_key?("setlistdata")}
      raise ApiParseError, "Missing setlist data" if concert_data.blank?

      return concert_data["setlistdata"]
    end
  end
end
