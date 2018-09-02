class ApiParseError < StandardError; end
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
    rescue ApiParseError => e
      puts "There was a problem parsing the setlist from the Phish.net API for concert #{@concert.id} - #{e.message}"
    rescue SetlistProcessingError => e
      puts "There was a problem processing the setlist for concert #{@concert.id} - #{e.message}"
    end

    private

    def pull_setlist
      puts "Pulling setlist for #{@concert.id}"
      raw_data = SetlistProcessing::ConcertDataClient.new(@concert).pull_setlist
      concert_json = JSON.parse(raw_data)
      return SetlistProcessing::SetlistParser.new(concert_json).parse
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
