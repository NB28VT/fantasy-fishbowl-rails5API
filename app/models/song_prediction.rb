class SongPrediction < ActiveRecord::Base
  belongs_to :song
  belongs_to :concert_prediction
end
