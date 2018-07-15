require 'rails_helper'

RSpec.describe PredictionCategory, type: :model do
  it {should validate_presence_of(:name)}
  it {should validate_presence_of(:set_number)}
  it {should validate_presence_of(:setlist_position)}
end
