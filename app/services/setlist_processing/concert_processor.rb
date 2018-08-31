class ApiParseError < StandardError; end
class SetlistProcessingError < StandardError; end

module SetlistProcessing
  class ConcertProcessor
    def initialize(concert)
      @concert = concert
      @setlist_data = []
    end

    def process
      get_setlist
      # validate_setlist
      save_setlist
      # score_predictions
    rescue ApiParseError => e
      # TODO: send notification for errors
      puts "There was a problem parsing the setlist from the Phish.net API for concert #{@concert.id} - #{e.message}"
    rescue SetlistProcessingError => e
      puts "There was a problem processing the setlist for concert #{@concert.id} - #{e.message}"
    end

    private

    def get_setlist
      raw_data = ConcertDataClient.new(@concert).pull_setlist
      concert_json = JSON.parse(raw_data)
      raise ApiParseError, "Error Pulling Setlist: #{concert_json["error_message"]}" if concert_json["error_message"]
      raise ApiParseError, "Setlist Not Found" if concert_json.dig("response", "count") == 0
      @setlist_data = SetlistProcessing::SetlistParser.new(concert_json).parse
    end

    def save_setlist
      @setlist_data[:concert_sets].each{|set| build_set(set) }
    end

    def validate_setlist
      # Confirm all needed values are present in parsed data
    end

    def build_set(set_attributes)
      concert_set = @concert.concert_sets.find_or_initialize_by(set_number: set_attributes[:set_number])
      if @concert.save!
        build_song_performances(concert_set, set_attributes)
      else
        raise SetlistProcessingError, "Problem saving concert sets: #{@concert.errors}"
      end
    end

    def build_song_performances(concert_set, set_attributes)
      set_attributes[:song_performances].each{|performance_attributes| concert_set.song_performances << build_song_performance(performance_attributes)}
      @concert.save!
      raise SetlistProcessingError, "Problem saving concert sets: #{@concert.errors}" if @concert.errors.present?
    end

    def build_song_performance(performance_attributes)
      # TODO: how to reconcile song names that might be spelled incorrectly?
      song = Song.find_or_create_by(name: performance_attributes[:song_name])
      SongPerformance.find_or_initialize_by(song: song, setlist_position: performance_attributes[:setlist_position])
    end
  end
end
