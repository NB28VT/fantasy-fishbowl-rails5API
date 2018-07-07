require 'rails_helper'

RSpec.describe PredictionCategory, type: :model do
  it {should validate_presence_of(:name)}
end
