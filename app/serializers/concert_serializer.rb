class ConcertSerializer < ActiveModel::Serializer
  attributes :id, :show_date, :venue_name, :sets

  def show_date
    object.show_date.strftime("%m/%d/%Y")
  end

  def sets
    object.concert_sets
  end
end
