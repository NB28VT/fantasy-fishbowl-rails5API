class ApiParseError < StandardError; end

module SetlistProcessing
  class SetlistParser
    def initialize(raw_data)
      @concert_json = JSON.parse(raw_data)
    end

    def parse
      validate_setlist_data
      parsed_html = Nokogiri::HTML(setlist_data)
      sets = parsed_html.search("p")
      raise ApiParseError, "No set paragraphs found" if sets.blank?

      concert_sets = sets.map.with_index do |set_data, set_number|
        {
          set_number: set_number,
          song_performances: build_song_performances(set_data)
        }
      end

      return {concert_sets: concert_sets}
    end

    private

    def validate_setlist_data
      raise ApiParseError, "Phish.net Error Message: #{@concert_json["error_message"]}" if @concert_json["error_message"].present?
      raise ApiParseError, "Empty Search Results" if @concert_json["response"]["count"] == 0
      raise ApiParseError, "Empty Response Data" if @concert_json.dig("response", "data").blank?
      raise ApiParseError, "Missing Setlist Data" if @concert_json.dig("response", "data").find{|data| data.has_key?("setlistdata")}.nil?
    end

    def setlist_data
      concert_result = @concert_json["response"]["data"].first
      return concert_result["setlistdata"]
    end

    def build_concert_set(set_data, set_index)
      return {
        set_number: set_index,
        song_performances: build_song_performances(set_data)
      }
    end

    def build_song_performances(set_data)
      return set_data.search("a").map.with_index{|song, setlist_position|  {song_name: song.text, setlist_position: setlist_position}}
    end
  end
end
