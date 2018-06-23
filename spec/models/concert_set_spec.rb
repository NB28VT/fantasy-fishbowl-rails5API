require 'rails_helper'

RSpec.describe ConcertSet, type: :model do
  it {should belong_to(:concert)}
  it {should have_many(:song_performances)}
  it {should have_many(:songs).through(:song_performances)}

  it {should validate_presence_of(:set_number)}
  it {should validate_presence_of(:concert_id)}
end
