class ConcertSerializer < ActiveModel::Serializer
  attributes :id, :show_date, :venue_name

  def show_date
    object.show_date.strftime("%m/%d/%Y")
  end

  has_many :concert_sets
end
