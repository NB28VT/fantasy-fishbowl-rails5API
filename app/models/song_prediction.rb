class SongPrediction < ActiveRecord::Base
  belongs_to :song
  belongs_to :concert_prediction

  # TODO: consider tying this directly to concert set
  validates_presence_of :setlist_position
  validates_presence_of :set_position
end
