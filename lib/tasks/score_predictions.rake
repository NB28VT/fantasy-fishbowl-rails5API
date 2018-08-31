desc "Save new concert performances"
task :process_concert_performance do
  # TODO: dump onto worker
  # Remember when you run this the first time it will query all past concerts
  pending_concerts = Concert.performed.missing_setlist

end

desc "Score unscored predictions"
task :process_pending_predictions do
  pending_predictions = Prediction.unscored

end
