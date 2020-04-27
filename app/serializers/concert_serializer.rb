class ConcertSerializer < ActiveModel::Serializer

  attributes :id, :show_time, :venue_name, :venue_image_src

  def show_time
    object.show_time.strftime("%m/%d/%Y")
  end

  def venue_image_src
    rails_blob_path(object.venue_image, disposition: "attachment") if object.venue_image.attachment
  end

  has_many :concert_sets
end
