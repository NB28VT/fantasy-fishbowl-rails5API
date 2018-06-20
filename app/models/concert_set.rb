class ConcertSet < ApplicationRecord
  belongs_to :concert

  validates_presence_of :set_number
  validates_presence_of :concert_id
end
