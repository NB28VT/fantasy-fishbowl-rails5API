class SongPrediction < ActiveRecord::Base
  belongs_to :song
  belongs_to :concert_prediction
  belongs_to :prediction_category

  validates_presence_of :prediction_category_id
end
