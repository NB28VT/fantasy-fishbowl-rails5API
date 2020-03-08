require 'rails_helper'

RSpec.describe ConcertTour, type: :model do
    it {should validate_presence_of(:name)}
    it {should have_many(:concerts)}

    it {should validate_presence_of :name}
end