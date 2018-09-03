desc "Save new concert performances"
task process_concert_performances: :environment do
  Concert.performed.missing_setlist.each do |concert|
    begin
      SetlistProcessing::ConcertProcessor.new(concert).process
    rescue => e
      # TODO: send mailer or log
      puts "Problem processing concert #{concert.id}, #{e.message}"
    end
  end
end

desc "Score unscored predictions"
task process_pending_predictions: :environment do
  pending_predictions = ConcertPrediction.concert_performed.unscored

  pending_predictions.each do |prediction|
    begin
      PredictionScorer.new(prediction).score
    rescue => e
      # TODO: send mailer or log
      puts "Problem processing concert #{concert.id}, #{e.message}"
    end
  end
end
