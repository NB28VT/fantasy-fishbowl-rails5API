desc "Save new concert performances"
task process_concert_performances: :environment do
  # TODO: dump onto worker?
  # Remember when you run this the first time it will query all past concerts
  Concert.performed.missing_setlist.each do |concert|
    begin
      puts "Processing concert #{concert.id}"
      SetlistProcessing::ConcertProcessor.new(concert).process
    rescue => e
      puts "Problem processing concert #{concert.id}, #{e.message}"
    end
  end
end

desc "Score unscored predictions"
task process_pending_predictions: :environment do
  pending_predictions = ConcertPrediction.concert_performed.unscored
  pending_predictions.each do |prediction|
    begin
      puts "Scoring #{prediction.id}"
      PredictionScorer.new(prediction).score
    rescue => e
      puts "Problem processing concert #{concert.id}, #{e.message}"
    end
  end
end
