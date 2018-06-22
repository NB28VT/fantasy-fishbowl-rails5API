class SongPerformance < ApplicationRecord
  belongs_to :concert_set
  belongs_to :song

  validates_presence_of :concert_set_id
  validates_presence_of :song_id
  validates_presence_of :setlist_position
end
