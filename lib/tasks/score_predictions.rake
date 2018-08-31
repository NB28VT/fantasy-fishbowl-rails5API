desc "Save new concert performances"
task process_concert_performances: :environment do
  # TODO: dump onto worker
  # Remember when you run this the first time it will query all past concerts
  Concert.performed.missing_setlist.limit(1).each do |concert|
    puts "Processing concert #{concert.id}"
    SetlistProcessing::ConcertProcessor.new(concert).process
  end
end

desc "Score unscored predictions"
task process_pending_predictions: :environment do
  pending_predictions = Prediction.unscored

end
