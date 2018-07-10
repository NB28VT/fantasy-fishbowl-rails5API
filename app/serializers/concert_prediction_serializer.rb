class ConcertPredictionSerializer < ActiveModel::Serializer
  attributes :id, :concert_id, :submission_score
  has_many :song_predictions
end
