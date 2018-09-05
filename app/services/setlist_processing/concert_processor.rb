module SetlistProcessing
  class ConcertProcessor
    def initialize(concert)
      @concert = concert
    end

    def process
      setlist_data = pull_setlist
      save_setlist(setlist_data)
    rescue => e
      # TODO: admin mailer alert
      raise "There was a problem processing the setlist for concert #{@concert.id} - #{e.class}\n #{e.message}\n #{e.backtrace}"
    end

    private

    def pull_setlist
      params = {showdate: @concert.formatted_show_time}
      api_response = PhishNetApiClient.new.api_get("setlists/get", params)
      raise PhishNetConnectionError, "Error in get response: #{response.response_code}, #{response.body_str}" if api_response[:code] != 200
      raw_data = api_response[:body]

      return SetlistProcessing::SetlistParser.new(raw_data).parse
    end

    def save_setlist(setlist_data)
      Concert.transaction do
        setlist_data[:concert_sets].each{|set| build_set(set) }
      end
    end

    def build_set(set_attributes)
      concert_set = @concert.concert_sets.find_or_create_by(set_number: set_attributes[:set_number])
      build_song_performances(concert_set, set_attributes)
    end

    def build_song_performances(concert_set, set_attributes)
      set_attributes[:song_performances].each{|performance_attributes| concert_set.song_performances << build_song_performance(performance_attributes)}
    end

    def build_song_performance(performance_attributes)
      song = Song.find_or_create_by(name: performance_attributes[:song_name])
      SongPerformance.find_or_create_by(song: song, setlist_position: performance_attributes[:setlist_position])
    end
  end
end
