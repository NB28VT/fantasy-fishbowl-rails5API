class ConcertIndexSerializer < ActiveModel::Serializer
  attributes :id, :show_time, :venue_name

  def show_time
    object.show_time.strftime("%m/%d/%Y")
  end
end
