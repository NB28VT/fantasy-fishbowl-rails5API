class PredictionScorer
  def initialize(concert_prediction)
    @concert_prediction = concert_prediction
    @sets = concert_prediction.concert.concert_sets
    @song_performances = concert_prediction.concert.song_performances
  end

  def score
    score = @concert_prediction.song_predictions.sum{|song_prediction| score_song(song_prediction)}
    @concert_prediction.score = score
    @concert_prediction.save!
  end

  private

  def score_song(song_prediction)
    return 3 if correct_placement?(song_prediction)
    return 1 if song_performed?(song_prediction)
    return 0
  end

  def correct_placement?(song_prediction)
    category = song_prediction.prediction_category
    return false if !category.set_number && !category.setlist_position
    return false if category.set_number && !@song_performances.where(concert_set: {set_number: category.set_number}, song: song_prediction.song)

    set = @sets.find_by(set_number: category.set_number)
 
    return correct_postion?(category.setlist_position, set, song_prediction.song)
  end


  def correct_postion?(position, set, song)
    if position == -1
      # Hardcode for now
      set.song_performances.order(setlist_position: :desc).last.song == song
    else
      set.song_performances.find_by(setlist_position: position).try(:song) == song
    end
  end

  def song_performed?(song_prediction)
    @song_performances.exists?(song: song_prediction.song)
  end
end
