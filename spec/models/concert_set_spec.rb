require 'rails_helper'

RSpec.describe ConcertSet, type: :model do
  it {should belong_to(:concert)}

  it {should validate_presence_of(:set_number)}
  it {should validate_presence_of(:concert_id)}
end
