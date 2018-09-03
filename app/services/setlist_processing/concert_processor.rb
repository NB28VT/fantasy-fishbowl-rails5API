class SetlistProcessingError < StandardError; end

module SetlistProcessing
  class ConcertProcessor
    def initialize(concert)
      @concert = concert
    end

    def process
      setlist_data = pull_setlist
      persist_setlist(setlist_data)
      puts "Completed setlist for #{@concert.id}"
    rescue => e
      puts "There was a problem processing the setlist for concert #{@concert.id} - #{e.class}\n #{e.message}\n #{e.backtrace}"
    end

    private

    def pull_setlist
      puts "Pulling setlist for #{@concert.id}"
      params = {showdate: @concert.formatted_show_time}
      raw_data = PhishNetApiClient.new.api_get("setlists/get", params)
      return SetlistProcessing::SetlistParser.new(raw_data).parse
    end


    def persist_setlist(setlist_data)
      setlist_data[:concert_sets].each{|set| build_set(set) }
    end

    def build_set(set_attributes)
      concert_set = @concert.concert_sets.find_or_initialize_by(set_number: set_attributes[:set_number])
      @concert.save!
      raise SetlistProcessingError, "Problem saving concert sets: #{@concert.errors}" if @concert.errors.present?
      build_song_performances(concert_set, set_attributes)
    end

    def build_song_performances(concert_set, set_attributes)
      set_attributes[:song_performances].each{|performance_attributes| concert_set.song_performances << build_song_performance(performance_attributes)}
      @concert.save!
      raise SetlistProcessingError, "Problem saving concert song performances: #{@concert.errors}" if @concert.errors.present?
    end

    def build_song_performance(performance_attributes)
      song = Song.find_or_initialize_by(name: performance_attributes[:song_name])
      SongPerformance.find_or_initialize_by(song: song, setlist_position: performance_attributes[:setlist_position])
    end
  end
end
