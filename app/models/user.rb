class User < ApplicationRecord
  has_secure_password

  has_many :concert_predictions
end
