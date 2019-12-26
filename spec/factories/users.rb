FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    name { Faker::Name.name  }
    password { "BrianAndRobert" }
    password_confirmation { "BrianAndRobert" }
  end
end
