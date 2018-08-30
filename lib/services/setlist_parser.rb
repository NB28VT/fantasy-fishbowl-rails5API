module Services
  class SetListParser
    attr_reader :setlist_data

    def initialize(setlist_data)
      @setlist_data = JSON.parse(setlist_data)
    end

    def parse
      parsed_setlist = {concert_sets: []}
      # TODO: clean up!
      setlist = @setlist_data["response"]["data"][0]["setlistdata"]
      document = Nokogiri::HTML(setlist)

      # break into smaller methods

      sets = document.search("p")

      sets.each_with_index do |set, set_number|
        set_attributes = []
        song_performances = set.search("a").map.with_index{|song, index|  {song_name: song.text, setlist_position: index}}

        set_attributes = {
          set_number: set_number,
          song_performances: song_performances
        }

        parsed_setlist[:concert_sets] << set_attributes
      end

      return parsed_setlist
    end
  end
end
