class SongPredictionSerializer < ActiveModel::Serializer
  attributes :id, :song, :category

  def song
    object.song.name
  end

  def category
    object.prediction_category.name
  end
end
