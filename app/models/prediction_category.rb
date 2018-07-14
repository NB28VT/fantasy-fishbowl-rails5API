class PredictionCategory < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :set_number
  validates_presence_of :setlist_position
end
