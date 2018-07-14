require "rails_helper"
require_relative "../../lib/services/prediction_scorer.rb"

RSpec.describe "PredictionScorer" do
  describe "#call" do
    it "scores a correctly placed song" do
      concert = create(:concert)
      concert_set = create(:concert_set, concert: concert, set_number: 1)
      song_performance = create(:song_performance, concert_set: concert_set, setlist_position: -1)

      category = create(:prediction_category, set_number: concert_set.set_number, setlist_position: song_performance.setlist_position)
      concert_prediction = create(:concert_prediction, concert: concert)

      song_prediction = create(:song_prediction,
        concert_prediction: concert_prediction,
        song: song_performance.song,
        prediction_category: category
      )

      expect(PredictionScorer.call(concert_prediction)).to eq(5)
    end

    it "scores a song that was played but not in the predicted position" do
      concert = create(:concert)
      concert_set = create(:concert_set, concert: concert, set_number: 1)
      song_performance = create(:song_performance, concert_set: concert_set, setlist_position: -1)

      category = create(:prediction_category, set_number: concert_set.set_number, setlist_position: 1)
      concert_prediction = create(:concert_prediction, concert: concert)

      song_prediction = create(:song_prediction,
        concert_prediction: concert_prediction,
        song: song_performance.song,
        prediction_category: category
      )

      expect(PredictionScorer.call(concert_prediction)).to eq(1)
    end




  end
end
