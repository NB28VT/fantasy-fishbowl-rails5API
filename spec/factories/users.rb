FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { "BrianAndRobert" }
    password_confirmation { "BrianAndRobert" }
  end
end
