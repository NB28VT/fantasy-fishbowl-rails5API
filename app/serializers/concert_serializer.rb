class ConcertSerializer < ActiveModel::Serializer
  attributes :id, :show_time, :venue_name

  def show_time
    object.show_time.strftime("%m/%d/%Y")
  end

  has_many :concert_sets
end
