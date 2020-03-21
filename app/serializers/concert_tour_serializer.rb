class ConcertTourSerializer < ActiveModel::Serializer
  attributes :id, :name, :concerts

  def concerts
    object.concerts
  end
end
