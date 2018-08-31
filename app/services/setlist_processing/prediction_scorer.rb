module SetlistProcessing
  class PredictionScorer
    def initialize(prediction)
      @prediction = prediction
      @concert = @prediction.concert
      @score = 0
    end

    def self.call(prediction)
      new(prediction).call
    end

    def call
      score_setlist_positions
      # score_category_songs
      return @score
    end

    private

    def score_setlist_positions
      @prediction.song_predictions.each {|song_prediction| score_song_prediction(song_prediction)}
    end

    def score_song_prediction(song_prediction)
      if correct_set_position?(song_prediction)
        @score += 3
      elsif song_performed?(song_prediction)
        @score += 1
      end
    end

    def correct_set_position?(song_prediction)
      category = song_prediction.prediction_category
      set = @concert.concert_sets.find_by(set_number: category.set_number)
      raise "Concert Set could not be found for prediction category" unless set.present?
      song_performance = set.song_performances.find_by(setlist_position: category.setlist_position)
      return song_performance.present? ? (song_prediction.song == song_performance.song) : false
    end

    def song_performed?(song_prediction)
      @concert.song_performances.where(song: song_prediction.song)
    end
  end
end
