class Concert < ApplicationRecord
  has_many :concert_sets, dependent: :destroy

  validates_presence_of :venue_name
  validates_presence_of :show_date
end
