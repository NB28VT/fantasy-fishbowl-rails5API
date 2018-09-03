class ApiParseError < StandardError; end

module SetlistProcessing
  class SetlistParser
    def initialize(raw_data)
      @json_data = JSON.parse(raw_data)
    end

    def parse
      SetlistProcessing::SetlistValidator.new(@json_data).validate
      parsed_setlist = parse_setlist_data
      set_list_attributes = build_setlist(parsed_setlist)

      return {concert_sets: set_list_attributes}
    end

    private

    def parse_setlist_data
      response_data = @json_data["response"]["data"].first
      parsed_html = Nokogiri::HTML(response_data["setlistdata"])
      concert_sets = parsed_html.search("p")
      raise ApiParseError, "No set paragraphs found" if concert_sets.blank?

      return concert_sets
    end

    def build_setlist(concert_sets)
      concert_sets.map.with_index do |set_data, set_number|
        {set_number: set_number, song_performances: build_song_performances(set_data)}
      end
    end

    def build_song_performances(set_data)
      set_data.search("a").map.with_index{|song, setlist_position|  {song_name: song.text, setlist_position: setlist_position}}
    end
  end
end
