require "rails_helper"

RSpec.describe SongPrediction, type: :model do
  it {should belong_to(:song)}
  it {should belong_to(:concert_prediction)}

  it {should validate_presence_of(:set_position)}
  it {should validate_presence_of(:setlist_position)}
end
