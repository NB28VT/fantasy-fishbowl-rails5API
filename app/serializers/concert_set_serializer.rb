class ConcertSetSerializer < ActiveModel::Serializer
  attributes :set_number

  has_many :song_performances

  def song_performances
    object.song_performances.order("setlist_position ASC")
  end
end
