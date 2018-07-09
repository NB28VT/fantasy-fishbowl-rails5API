class ConcertPredictionSerializer < ActiveModel::Serializer
  attributes :id, :concert_id
  has_many :song_predictions
end
