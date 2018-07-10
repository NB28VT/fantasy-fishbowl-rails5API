class ConcertPredictionSerializer < ActiveModel::Serializer
  attributes :id, :concert_id, :user_id, :score
  has_many :song_predictions
end
