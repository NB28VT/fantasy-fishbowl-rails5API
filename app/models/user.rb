class User < ApplicationRecord
  has_secure_password

  has_many :concert_predictions

  validates_presence_of :name

  def self.rank_users
    users = User.all
    return users.map{|u| {name: u.name, total_score: u.total_score} }.sort_by!{|u| u[:total_score]}.reverse
  end

  def total_score
    return ConcertPrediction.where(user: self).sum(:score)
  end
end
