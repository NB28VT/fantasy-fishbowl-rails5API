require 'rails_helper'

RSpec.describe Concert, type: :model do
  it {should have_many(:concert_sets).dependent(:destroy)}
  it {should have_many(:song_performances).through(:concert_sets).dependent(:destroy)}
  it {should have_many(:concert_predictions).dependent(:destroy)}
  it {should belong_to(:concert_tour)}

  it {should validate_presence_of :venue_name}
  it {should validate_presence_of :show_time}
end
