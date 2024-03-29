FactoryBot.define do
  factory :concert do
    concert_tour
    show_time { Faker::Date.between(30.years.ago, 1.day.ago) }
    venue_name { Faker::Address.city }
  end
end
