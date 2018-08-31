class Concert < ApplicationRecord
  has_many :concert_sets, dependent: :destroy
  has_many :concert_predictions, dependent: :destroy
  has_many :song_performances, through: :concert_sets, dependent: :destroy

  validates_presence_of :venue_name
  validates_presence_of :show_date

  # 8 Hours after show start
  # Don't need santize here:
  scope :performed, -> { where("show_time < ?",  8.hours.ago) }
  scope :missing_setlist, -> { left_joins(:concert_sets).where(concert_sets: {id: nil})}
end
