require "rails_helper"

RSpec.describe SongPrediction, type: :model do
  it {should belong_to(:song)}
  it {should belong_to(:concert_prediction)}
  it {should belong_to(:prediction_category)}

  it {should validate_presence_of(:prediction_category_id)}
end
