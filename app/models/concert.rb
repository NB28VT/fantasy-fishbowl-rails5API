class Concert < ApplicationRecord
  has_many :concert_sets, dependent: :destroy
  has_many :concert_predictions, dependent: :destroy
  has_many :song_performances, through: :concert_sets, dependent: :destroy

  has_one_attached :venue_image

  belongs_to :concert_tour

  validates_presence_of :venue_name
  validates_presence_of :show_time

  scope :performed, -> { where("show_time < ?",  8.hours.ago) }
  scope :missing_setlist, -> { left_joins(:concert_sets).where(concert_sets: {id: nil}) }
  scope :with_setlist, -> { joins(:concert_sets).distinct }

  def formatted_show_time
    self.show_time.strftime('%F')
  end
end
