class ConcertPrediction < ApplicationRecord
  belongs_to :user
  belongs_to :concert

  has_many :song_predictions, dependent: :destroy
  has_many :songs, through: :song_predictions

  validates_presence_of :user_id
  validates_presence_of :concert_id
  # TODO: validate uniqueness of song predictions: i.e.,
  # can't create two predictions for the same set and set position
end
