require 'rails_helper'

RSpec.describe ConcertPrediction, type: :model do
  it {should belong_to(:concert)}
  it {should belong_to(:user)}
  it {should have_many(:song_predictions)}
  it {should have_many(:songs).through(:song_predictions)}

  it {should validate_presence_of(:concert_id)}
  it {should validate_presence_of(:user_id)}
end
