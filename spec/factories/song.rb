FactoryBot.define do
  factory :song do
    name { Faker::Music::UmphreysMcgee.song }
  end
end
