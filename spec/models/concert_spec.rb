require 'rails_helper'

RSpec.describe Concert, type: :model do
  it {should have_many(:concert_sets).dependent(:destroy)}
  it {should have_many(:concert_predictions).dependent(:destroy)}

  it {should validate_presence_of :venue_name}
  it {should validate_presence_of :show_date}
end
