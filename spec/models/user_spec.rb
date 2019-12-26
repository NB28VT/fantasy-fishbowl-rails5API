require 'rails_helper'

RSpec.describe User, type: :model do
  it {should have_many(:concert_predictions)}
  it {should validate_presence_of :name}

  describe ".rank_users" do
    it "returns a list of user names ranked by their total prediction score" do
      build_user_with_predictions(6)
      build_user_with_predictions(8)
      build_user_with_predictions(2)

      rankings = User.rank_users

      expect(rankings.length()).to eq(3)
      expect(rankings.map{|user| user[:total_score]}).to eq ([8, 6, 2])
      expect(rankings.all?{|user| user[:name].is_a?(String)}).to eq(true)
    end

    it "returns an empty array if no users are present" do
      rankings = User.rank_users
      expect(rankings.length()).to eq(0)
    end

    it "returns all zero scores if no predictions have been scored" do
      3.times do
        build_user_with_predictions()
      end

      rankings = User.rank_users
      expect(rankings.map{|user| user[:total_score]}).to eq ([0, 0, 0])
    end
  end

  def build_user_with_predictions(prediction_score = nil)
      user = create(:user)
      concert = create(:concert)
      concert_prediction = create(:concert_prediction, user: user, concert: concert, score: prediction_score)
  end
end
