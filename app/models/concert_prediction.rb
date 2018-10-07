class ConcertPrediction < ApplicationRecord
  belongs_to :user
  belongs_to :concert

  has_many :song_predictions, dependent: :destroy, inverse_of: :concert_prediction
  has_many :songs, through: :song_predictions

  accepts_nested_attributes_for :song_predictions

  validates_presence_of :user_id
  validates_presence_of :concert_id

  scope :concert_performed, -> { joins(:concert).merge(Concert.performed.with_setlist) }
  scope :unscored, -> { where(score: nil) }
end
