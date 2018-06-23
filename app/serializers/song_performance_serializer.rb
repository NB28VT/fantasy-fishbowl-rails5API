class SongPerformanceSerializer < ActiveModel::Serializer
  attributes :name

  def name
    object.song.name
  end
end
